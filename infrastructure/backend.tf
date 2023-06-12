terraform {
  required_version = ">= 1.2.9"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.56.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstatekvb8g"
    container_name       = "lz-tfstate"
    key                  = "privatelink.tfstate"
    tenant_id            = "986ff2ce-27f4-49a1-9c99-616e64ee6195"
  }
}