resource "azurerm_virtual_network" "IaaS_network" {
  name                = "IaaS_network"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.name
}

resource "azurerm_subnet" "IaaS_subnet" {
  name                 = "IaaS_subnet"
  resource_group_name  = var.name
  virtual_network_name = azurerm_virtual_network.IaaS_network.name
  address_prefixes     = ["10.0.1.0/24"]

}

resource "azurerm_public_ip" "IaaS_public_ip" {
  name                = "IaaS_public_ip"
  location            = var.location
  resource_group_name = var.name
  allocation_method   = "Dynamic"

}

resource "azurerm_network_interface" "nic" {
  name                = "IaaS_nic"
  location            = var.location
  resource_group_name = var.name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.IaaS_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.IaaS_public_ip.id
  }

}
resource "azurerm_network_interface_security_group_association" "iaas_sg_as" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = var.sg_id
}
