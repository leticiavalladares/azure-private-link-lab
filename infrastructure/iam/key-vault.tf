resource "azurerm_role_assignment" "role_assign" {
  for_each = local.role_assign

  scope              = each.value.scope
  role_definition_id = each.value.role_definition_id
  principal_id       = each.value.principal_id

  lifecycle {
    ignore_changes = all
  }
}