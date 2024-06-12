resource "azurerm_virtual_network" "IaaS_network" {
  name          = "IaaS_network"
  address_space = ["10.0.2.0/16"]
  location      = 

}
