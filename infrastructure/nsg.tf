resource "azurerm_network_security_group" "nsg" {
  for_each = local.nsgs

  name                = "nsg-${each.key}-${substr(each.value.location, 0, 1)}${local.resource_suffix}"
  location            = each.value.location
  resource_group_name = azurerm_resource_group.resource_group[each.value.vnet].name

  dynamic "security_rule" {
    for_each = local.nsgs[each.key].security_rules

    content {
      name                       = security_rule.key
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.from_port
      destination_port_range     = security_rule.value.to_port
      source_address_prefix      = security_rule.value.cidr_block
      destination_address_prefix = "*"
    }
  }

  tags = merge(local.default_tags, {
    Name = "nsg-${each.key}-${substr(each.value.location, 0, 1)}${local.resource_suffix}"
  })

  depends_on = [azurerm_resource_group.resource_group]
}

resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  for_each = { for subnet, val in local.subnets : val.name => val if val.nsg != "" }

  subnet_id                 = azurerm_subnet.subnet[each.value.name].id
  network_security_group_id = azurerm_network_security_group.nsg[each.value.nsg].id

  depends_on = [azurerm_resource_group.resource_group]
}
