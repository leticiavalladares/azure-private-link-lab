resource "azurerm_role_assignment" "role_assign" {
  for_each = local.role_assign

  scope              = each.value.scope
  role_definition_id = each.value.role_definition_id
  principal_id       = each.value.principal_id

  lifecycle {
    ignore_changes = all
  }
}

resource "azurerm_key_vault" "key_vault" {
  for_each = local.net_watchers

  name                       = "kv${substr(each.value.location, 0, 1)}${trim(tostring(local.resource_suffix), "-")}"
  location                   = data.azurerm_network_watcher.net_watcher[each.key].location
  resource_group_name        = each.value.rg_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 7
  purge_protection_enabled   = false
  sku_name                   = "standard"
  enable_rbac_authorization  = true

  tags = merge(local.default_tags, {
    Name = "kv${substr(each.value.location, 0, 1)}${trim(tostring(local.resource_suffix), "-")}"
  })
}

resource "tls_private_key" "ssh_key" {
  for_each = local.vms

  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_key_vault_secret" "secret" {
  for_each = local.vms

  name         = each.value.secret_name
  value        = tls_private_key.ssh_key[each.key].private_key_pem
  key_vault_id = azurerm_key_vault.key_vault[each.value.location].id
}