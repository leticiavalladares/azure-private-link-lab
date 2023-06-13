data "azurerm_network_watcher" "net_watcher" {
  for_each = local.net_watchers

  name                = each.value.name
  resource_group_name = each.value.rg_name
}
