resource "azurerm_storage_account" "storage" {
  for_each = local.vnets

  name                      = each.value.storage_name
  resource_group_name       = azurerm_resource_group.resource_group[each.key].name
  location                  = each.value.location
  account_replication_type  = "LRS"
  account_tier              = "Standard"
  account_kind              = "StorageV2"
  access_tier               = "Hot"
  min_tls_version           = "TLS1_2"
  enable_https_traffic_only = true

  blob_properties {
    delete_retention_policy {
      days = 7
    }
  }

  network_rules {
    default_action             = "Deny"
    bypass                     = ["AzureServices", "Logging", "Metrics"]
    ip_rules                   = []
    virtual_network_subnet_ids = []
  }

  tags = merge(local.default_tags, {
    Name = each.value.storage_name
  })

  depends_on = [azurerm_resource_group.resource_group]
}

resource "azurerm_storage_account" "diag" {
  for_each = local.vnets # Debug: { for vnet, val in local.vnets : vnet => val} #  if vnet != "external"

  name                      = each.value.diag_name
  resource_group_name       = azurerm_resource_group.resource_group[each.key].name
  location                  = each.value.location
  account_replication_type  = "LRS"
  account_tier              = "Standard"
  account_kind              = "StorageV2"
  access_tier               = "Hot"
  min_tls_version           = "TLS1_2"
  enable_https_traffic_only = true

  blob_properties {
    delete_retention_policy {
      days = 7
    }
  }

  network_rules {
    default_action             = "Deny"
    bypass                     = ["AzureServices", "Logging", "Metrics"]
    ip_rules                   = []
    virtual_network_subnet_ids = []
  }

  tags = merge(local.default_tags, {
    Name = each.value.diag_name
  })

  depends_on = [azurerm_resource_group.resource_group]
}