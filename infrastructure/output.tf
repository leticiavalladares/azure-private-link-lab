output "vnet_id" {
  value       = values(azurerm_virtual_network.vnet)[*].id
  description = "Vnet id"
}