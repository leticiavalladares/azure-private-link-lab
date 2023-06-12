<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.9 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =3.56.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.56.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_log_analytics_linked_storage_account.logs](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/log_analytics_linked_storage_account) | resource |
| [azurerm_log_analytics_workspace.log_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/log_analytics_workspace) | resource |
| [azurerm_network_security_group.nsg](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/network_security_group) | resource |
| [azurerm_network_watcher_flow_log.log](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/network_watcher_flow_log) | resource |
| [azurerm_resource_group.resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/resource_group) | resource |
| [azurerm_route_table.route_table](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/route_table) | resource |
| [azurerm_storage_account.diag](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/storage_account) | resource |
| [azurerm_storage_account.storage](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/storage_account) | resource |
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.nsg_assoc](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_route_table_association.route_table_assoc](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/subnet_route_table_association) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network_peering.vnet_peering_to_hub](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.vnet_peering_to_spoke](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/virtual_network_peering) | resource |
| [azurerm_network_watcher.net_watcher_westeu](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/data-sources/network_watcher) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_my_ip"></a> [my\_ip](#input\_my\_ip) | IP for ssh | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vnet_id"></a> [vnet\_id](#output\_vnet\_id) | Vnet id |
<!-- END_TF_DOCS -->