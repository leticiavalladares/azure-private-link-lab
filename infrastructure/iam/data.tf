data "azurerm_network_watcher" "net_watcher" {
  for_each = local.net_watchers

  name                = each.value.name
  resource_group_name = each.value.rg_name
}

data "azurerm_client_config" "current" {}

data "azurerm_role_definition" "role_definition" {
  for_each = toset(local.roles)

  name = each.key
}
