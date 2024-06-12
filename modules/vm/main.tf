resource "tls_private_key" "ssh_key_iaas" {

  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_linux_virtual_machine" "iaas_vm" {
  name                  = "iaas_vm"
  location              = var.rg_location
  resource_group_name   = var.rg_name
  network_interface_ids = [var.nic_id]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "iaas_disk"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = "iaasVM"
  admin_username                  = "mikita"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "mikita"
    public_key = tls_private_key.ssh_key_iaas.public_key_openssh
  }
}
resource "local_file" "key" {
  filename = "../../private-key-iaas"
  content  = tls_private_key.ssh_key_iaas.private_key_openssh
}
