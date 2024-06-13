output "network_name" {

  value = azurerm_virtual_network.IaaS_network.name
}

output "nic_id" {
  value = [for nic in azurerm_network_interface.nic : nic.id]

}
output "subnet_id" {
  value = azurerm_subnet.IaaS_subnet.id
}
output "public_ip_address" {
  value = [for ip in azurerm_public_ip.IaaS_public_ip : ip.id]
}
