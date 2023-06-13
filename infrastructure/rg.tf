resource "azurerm_resource_group" "resource_group" {
  for_each = local.vnets

  name     = "rg-${each.key}-${substr(each.value.location, 0, 1)}${local.resource_suffix}"
  location = each.value.location

  tags = merge(local.default_tags, {
    Name = "rg-${each.key}-${substr(each.value.location, 0, 1)}${local.resource_suffix}"
  })
}