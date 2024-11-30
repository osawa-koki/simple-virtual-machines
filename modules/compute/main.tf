resource "azurerm_linux_virtual_machine" "my_vm" {
  name                = "${var.project_name}-machine"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
  size                = "Standard_F2"
  admin_username      = "ubuntu"
  network_interface_ids = [
    var.network_interface_id
  ]

  admin_ssh_key {
    username   = "ubuntu"
    public_key = var.ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
