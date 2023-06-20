<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | = 1.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =3.56.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.56.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/key_vault) | resource |
| [azurerm_key_vault_secret.secret](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/key_vault_secret) | resource |
| [azurerm_lb.lb](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/lb) | resource |
| [azurerm_log_analytics_linked_storage_account.logs](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/log_analytics_linked_storage_account) | resource |
| [azurerm_log_analytics_workspace.log_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/log_analytics_workspace) | resource |
| [azurerm_network_security_group.nsg](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/network_security_group) | resource |
| [azurerm_network_watcher_flow_log.log](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/network_watcher_flow_log) | resource |
| [azurerm_private_dns_resolver.dns_resolver](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/private_dns_resolver) | resource |
| [azurerm_private_dns_resolver_dns_forwarding_ruleset.dns_forwarding_rule_set](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/private_dns_resolver_dns_forwarding_ruleset) | resource |
| [azurerm_private_dns_resolver_inbound_endpoint.dns_inbound_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/private_dns_resolver_inbound_endpoint) | resource |
| [azurerm_private_dns_resolver_outbound_endpoint.dns_outbound_point](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/private_dns_resolver_outbound_endpoint) | resource |
| [azurerm_private_dns_zone.private_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.private_dns_vnet_link](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_link_service.plink_service](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/private_link_service) | resource |
| [azurerm_resource_group.resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.role_assign](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/role_assignment) | resource |
| [azurerm_route_table.route_table](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/route_table) | resource |
| [azurerm_storage_account.diag](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/storage_account) | resource |
| [azurerm_storage_account.storage](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/storage_account) | resource |
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.nsg_assoc](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_route_table_association.route_table_assoc](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/subnet_route_table_association) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network_peering.vnet_peering_to_hub](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.vnet_peering_to_spoke](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/virtual_network_peering) | resource |
| [tls_private_key.ssh_key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/data-sources/client_config) | data source |
| [azurerm_network_watcher.net_watcher](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/data-sources/network_watcher) | data source |
| [azurerm_role_definition.role_definition](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/data-sources/role_definition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_my_ip"></a> [my\_ip](#input\_my\_ip) | IP for ssh | `any` | n/a | yes |
| <a name="input_principal_id_dev_user_1"></a> [principal\_id\_dev\_user\_1](#input\_principal\_id\_dev\_user\_1) | Principal ID of user 1 for development | `any` | n/a | yes |
| <a name="input_principal_id_dev_user_2"></a> [principal\_id\_dev\_user\_2](#input\_principal\_id\_dev\_user\_2) | Principal ID of user 2 for development | `any` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | Subscription ID used to deploy infra | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vnet_id"></a> [vnet\_id](#output\_vnet\_id) | Vnet id |
<!-- END_TF_DOCS -->