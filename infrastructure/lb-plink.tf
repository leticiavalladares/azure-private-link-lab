# resource "azurerm_public_ip" "pip" {
#   for_each = local.pips

#   name                = "pip-${each.key}-${substr(each.value.location, 0, 1)}${local.resource_suffix}"
#   sku                 = each.value.sku
#   location            = azurerm_resource_group.resource_group[element(keys({ for n, val in local.vnets : n => val if val.type == "plink" }), 0)].location
#   resource_group_name = azurerm_resource_group.resource_group[element(keys({ for n, val in local.vnets : n => val if val.type == "plink" }), 0)].name
#   allocation_method   = each.value.alloc_method

#   tags = merge(local.default_tags, {
#     Name = "pip-${each.key}-${substr(each.value.location, 0, 1)}${local.resource_suffix}"
#   })
# }

resource "azurerm_lb" "lb" {
  for_each = local.lbs

  name                = "lb-${each.key}-${substr(each.value.location, 0, 1)}${local.resource_suffix}"
  sku                 = "Standard"
  location            = azurerm_resource_group.resource_group[element(keys({ for n, val in local.vnets : n => val if val.type == "plink" }), 0)].location
  resource_group_name = azurerm_resource_group.resource_group[element(keys({ for n, val in local.vnets : n => val if val.type == "plink" }), 0)].name

  frontend_ip_configuration {
    name                          = each.value.frontend_ip_name #azurerm_public_ip.pip[each.value.pip].name    
    private_ip_address_allocation = "Static"
    private_ip_address            = each.value.frontend_ip_address
    subnet_id                     = azurerm_subnet.subnet[each.value.snet].id
    #public_ip_address_id = azurerm_public_ip.pip[each.value.pip].id
  }

  tags = merge(local.default_tags, {
    Name = "lb-${each.key}-${substr(each.value.location, 0, 1)}${local.resource_suffix}"
  })
}

resource "azurerm_private_link_service" "plink_service" {
  for_each = local.plinkservices

  name                = "${each.key}-${substr(each.value.location, 0, 1)}${local.resource_suffix}"
  location            = azurerm_resource_group.resource_group[element(keys({ for n, val in local.vnets : n => val if val.type == "plink" }), 0)].location
  resource_group_name = azurerm_resource_group.resource_group[element(keys({ for n, val in local.vnets : n => val if val.type == "plink" }), 0)].name

  load_balancer_frontend_ip_configuration_ids = [azurerm_lb.lb[each.value.lb].frontend_ip_configuration.0.id]

  dynamic "nat_ip_configuration" {
    for_each = local.plinkservices[each.key].nat_ip_conf

    content {
      name                       = nat_ip_configuration.key
      private_ip_address         = nat_ip_configuration.value.private_ip
      private_ip_address_version = "IPv4"
      subnet_id                  = azurerm_subnet.subnet[nat_ip_configuration.value.snet].id
      primary                    = nat_ip_configuration.value.primary
    }
  }

  tags = merge(local.default_tags, {
    Name = "${each.key}-${substr(each.value.location, 0, 1)}${local.resource_suffix}"
  })

}