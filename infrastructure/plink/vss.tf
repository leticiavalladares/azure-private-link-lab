# resource "azurerm_linux_virtual_machine_scale_set" "virtual_scale_set" {
#   for_each = local.vmss

#   name                = "vmss-${each.key}-${substr(each.value.location, 0, 1)}${local.resource_suffix}"
#   location            = azurerm_resource_group.resource_group[element(keys({ for n, val in local.vnets : n => val if val.type == "plink" }), 0)].location
#   resource_group_name = azurerm_resource_group.resource_group[element(keys({ for n, val in local.vnets : n => val if val.type == "plink" }), 0)].name
#   sku                 = "Standard_F2"
#   instances           = 1
#   admin_username      = "adminuser"

#   admin_ssh_key {
#     username   = "adminuser"
#     public_key = local.first_public_key
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-focal"
#     sku       = "20_04-lts"
#     version   = "latest"
#   }

#   os_disk {
#     storage_account_type = "Standard_LRS"
#     caching              = "ReadWrite"
#   }

#   network_interface {
#     name    = "example"
#     primary = true

#     ip_configuration {
#       name      = "internal"
#       primary   = true
#       subnet_id = azurerm_subnet.internal.id
#     }
#   }
# }