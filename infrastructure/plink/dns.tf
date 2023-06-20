resource "azurerm_private_dns_zone" "private_dns_zone" {
  for_each = { for vnet, val in local.vnets : vnet => val if val.private_dns_zone == true }

  name                = "${each.key}plink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.resource_group[each.key].name
}

resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_vnet_link" {
  for_each = { for vnet, val in local.vnets : vnet => val if val.private_dns_zone == true }

  name                  = "dns-link-${each.key}-${substr(each.value.location, 0, 1)}${local.resource_suffix}"
  resource_group_name   = azurerm_resource_group.resource_group[each.key].name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone[each.key].name
  virtual_network_id    = azurerm_virtual_network.vnet[each.key].id
}