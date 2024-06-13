resource "tls_private_key" "ssh_key_iaas" {

  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_linux_virtual_machine" "iaas_vm" {
  count                 = 2
  name                  = "iaas_vm-${count.index}"
  location              = var.rg_location
  resource_group_name   = var.rg_name
  network_interface_ids = [var.nic_id[count.index]]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "iaas_disk-${count.index}"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = "iaasVM-${count.index}"
  admin_username                  = "mikita"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "mikita"
    public_key = tls_private_key.ssh_key_iaas.public_key_openssh
  }

}
resource "azurerm_virtual_machine_extension" "my_vm_extension" {
  count                = 2
  name                 = "docker"
  virtual_machine_id   = azurerm_linux_virtual_machine.iaas_vm[count.index].id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.1"

  settings = <<SETTINGS
 {
"commandToExecute": "sudo apt-get update && sudo apt-get install nginx -y && echo \"Hello World from $(hostname)\" > /var/www/html/index.html && sudo systemctl restart nginx"
 }
SETTINGS

}
resource "local_file" "key" {
  filename        = "../private-key-iaas"
  file_permission = "0500"
  content         = tls_private_key.ssh_key_iaas.private_key_openssh
}

