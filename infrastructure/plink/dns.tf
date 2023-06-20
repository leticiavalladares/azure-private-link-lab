resource "azurerm_private_dns_zone" "private_dns_zone" {
  for_each = { for vnet, val in local.vnets : vnet => val if val.private_dns_zone == true }

  name                = "${each.key}plink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.resource_group[each.key].name
}

resource "azurerm_private_dns_resolver" "dns_resolver" {
  for_each = { for vnet, val in local.vnets : vnet => val if val.private_dns_zone == true }

  name                = "resolver-${each.key}-${substr(each.value.location, 0, 1)}${local.resource_suffix}"
  resource_group_name = azurerm_resource_group.resource_group[each.key].name
  location            = azurerm_resource_group.resource_group[each.key].location
  virtual_network_id  = azurerm_virtual_network.vnet[each.key].id
}

resource "azurerm_private_dns_resolver_inbound_endpoint" "dns_inbound_endpoint" {
  for_each = { for subnet, val in local.subnets : val.name => val if val.endpoint_type == "inbound" }

  name                    = "${each.value.endpoint_type}-endpoint-${each.value.name}-${substr(each.value.location, 0, 1)}${local.resource_suffix}"
  private_dns_resolver_id = azurerm_private_dns_resolver.dns_resolver[each.value.vnet].id
  location                = azurerm_private_dns_resolver.dns_resolver[each.value.vnet].location

  ip_configurations {
    private_ip_allocation_method = "Dynamic"
    subnet_id                    = azurerm_subnet.subnet[each.value.name].id
  }

  tags = merge(local.default_tags, {
    Name = "${each.value.endpoint_type}-endpoint-${each.value.name}-${substr(each.value.location, 0, 1)}${local.resource_suffix}"
  })
}

resource "azurerm_private_dns_resolver_outbound_endpoint" "dns_outbound_point" {
  for_each = { for subnet, val in local.subnets : val.name => val if val.endpoint_type == "outbound" }

  name                    = "${each.value.endpoint_type}-endpoint-${each.value.name}-${substr(each.value.location, 0, 1)}${local.resource_suffix}"
  private_dns_resolver_id = azurerm_private_dns_resolver.dns_resolver[each.value.vnet].id
  location                = azurerm_private_dns_resolver.dns_resolver[each.value.vnet].location
  subnet_id               = azurerm_subnet.subnet[each.value.name].id

  tags = merge(local.default_tags, {
    Name = "${each.value.endpoint_type}-endpoint-${each.value.name}-${substr(each.value.location, 0, 1)}${local.resource_suffix}"
  })
}

resource "azurerm_private_dns_resolver_dns_forwarding_ruleset" "dns_forwarding_rule_set" {
  for_each = { for vnet, val in local.vnets : vnet => val if val.private_dns_zone == true }

  name                                       = "ruleset-${each.key}-${substr(each.value.location, 0, 1)}${local.resource_suffix}"
  resource_group_name                        = azurerm_resource_group.resource_group[each.key].name
  location                                   = azurerm_resource_group.resource_group[each.key].location
  private_dns_resolver_outbound_endpoint_ids = [azurerm_private_dns_resolver_outbound_endpoint.dns_outbound_point[element(keys({ for subnet, val in local.subnets : val.name => val if val.vnet == each.key && val.endpoint_type == "outbound" }), 0)].id]
}

resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_vnet_link" {
  for_each = { for vnet, val in local.vnets : vnet => val if val.private_dns_zone == true }

  name                  = "dns-link-${each.key}-${substr(each.value.location, 0, 1)}${local.resource_suffix}"
  resource_group_name   = azurerm_resource_group.resource_group[each.key].name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone[each.key].name
  virtual_network_id    = azurerm_virtual_network.vnet[each.key].id
}

# resource "azurerm_private_endpoint" "private_endpoint" {
#   for_each = { for subnet, val in local.subnets : val.name => val if val.endpoint_type != ""}

#   name                = "${each.value.endpoint_type}-endpoint-${each.value.name}-${substr(each.value.location, 0, 1)}${local.resource_suffix}"
#   location            = azurerm_resource_group.resource_group[each.value.vnet].location
#   resource_group_name = azurerm_resource_group.resource_group[each.value.vnet].name
#   subnet_id           = azurerm_subnet.subnet[each.value.name].id

#   private_service_connection {
#     name                           = "privateserviceconnection-${each.value.name}"
#     private_connection_resource_id = azurerm_private_link_service.plink_service[each.value.plink].id
#     is_manual_connection           = false
#   }
# }