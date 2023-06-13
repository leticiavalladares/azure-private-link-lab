resource "azurerm_virtual_network" "vnet" {
  for_each = local.vnets

  name                = "vnet-${each.key}-${substr(each.value.location, 0, 1)}${local.resource_suffix}"
  location            = each.value.location
  resource_group_name = "rg-${each.key}-${substr(each.value.location, 0, 1)}${local.resource_suffix}"
  address_space       = [each.value.cidr]
  dns_servers         = []

  tags = merge(local.default_tags, {
    Name = "vnet-${each.key}-${substr(each.value.location, 0, 1)}${local.resource_suffix}"
  })

  depends_on = [azurerm_resource_group.resource_group]
}

resource "azurerm_subnet" "subnet" {
  for_each = { for subnet, val in local.subnets : val.name => val }

  name                 = "snet-${each.value.name}-${substr(each.value.location, 0, 1)}${local.resource_suffix}"
  resource_group_name  = "rg-${each.value.vnet}-${substr(each.value.location, 0, 1)}${local.resource_suffix}"
  virtual_network_name = azurerm_virtual_network.vnet[each.value.vnet].name
  address_prefixes     = [each.value.cidr]
  service_endpoints    = []

  private_link_service_network_policies_enabled = each.value.plinkpol

  depends_on = [azurerm_resource_group.resource_group]
}