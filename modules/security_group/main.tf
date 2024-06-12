resource "azurerm_network_security_group" "iaas_sg" {
  name                = "iaas_sg"
  resource_group_name = var.rg_name
  location            = var.rg_location
  security_rule {
    name                       = "SSH"
    description                = "SSH_CONNECTIONS"
    protocol                   = "Tcp"
    access                     = "Allow"
    direction                  = "Inbound"
    priority                   = "100"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"

  }
}
