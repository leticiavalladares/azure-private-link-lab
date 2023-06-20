resource "azurerm_log_analytics_workspace" "log_workspace" {
  for_each = local.vnets

  name                = "${each.value.workspace}-${substr(each.value.location, 0, 1)}${local.resource_suffix}"
  location            = each.value.location
  resource_group_name = azurerm_resource_group.resource_group[each.key].name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = merge(local.default_tags, {
    Name = "${each.value.workspace}-${substr(each.value.location, 0, 1)}${local.resource_suffix}"
  })

  depends_on = [azurerm_resource_group.resource_group]
}

resource "azurerm_log_analytics_linked_storage_account" "logs" {
  for_each = local.vnets

  data_source_type      = "CustomLogs"
  resource_group_name   = azurerm_resource_group.resource_group[each.key].name
  workspace_resource_id = azurerm_log_analytics_workspace.log_workspace[each.key].id
  storage_account_ids   = [azurerm_storage_account.storage[each.key].id]

  lifecycle {
    ignore_changes = [
      data_source_type
    ]
  }

  depends_on = [azurerm_resource_group.resource_group]
}