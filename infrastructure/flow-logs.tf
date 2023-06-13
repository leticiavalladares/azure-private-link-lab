resource "azurerm_network_watcher_flow_log" "log" {
  for_each = local.nsgs

  name                 = "${each.key}-log"
  network_watcher_name = data.azurerm_network_watcher.net_watcher[each.value.location].name
  resource_group_name  = data.azurerm_network_watcher.net_watcher[each.value.location].resource_group_name
  location             = data.azurerm_network_watcher.net_watcher[each.value.location].location

  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
  storage_account_id        = azurerm_storage_account.storage[each.value.vnet].id
  enabled                   = true

  retention_policy {
    enabled = true
    days    = 365
  }

  traffic_analytics {
    enabled               = true
    workspace_id          = azurerm_log_analytics_workspace.log_workspace[each.value.vnet].workspace_id
    workspace_region      = azurerm_resource_group.resource_group[each.value.vnet].location
    workspace_resource_id = azurerm_log_analytics_workspace.log_workspace[each.value.vnet].id
    interval_in_minutes   = 60
  }

  version = 2

  depends_on = [azurerm_resource_group.resource_group]
}
