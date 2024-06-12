output "network_name" {

  value = azurerm_virtual_network.IaaS_network.name
}

output "nic_id" {
  value = azurerm_network_interface.nic.id

}
