# Create an Internal Load Balancer
resource "azurerm_lb" "my_lb" {
  name                = "Iaas_load_balancer"
  location            = var.rg_location
  resource_group_name = var.rg_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                          = "frontend-ip-iaas"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_address[2]
  }
}

resource "azurerm_lb_backend_address_pool" "my_lb_pool" {
  loadbalancer_id = azurerm_lb.my_lb.id
  name            = "iaas-pool"
}

resource "azurerm_network_interface_backend_address_pool_association" "name" {
  for_each                = { for idx, nic_id in var.nic_id : idx => nic_id }
  network_interface_id    = each.value
  ip_configuration_name   = "ip-config-${each.key}"
  backend_address_pool_id = azurerm_lb_backend_address_pool.my_lb_pool.id
}
resource "azurerm_lb_probe" "my_lb_probe" {
  loadbalancer_id = azurerm_lb.my_lb.id
  name            = "iaas-probe"
  port            = 80
}

resource "azurerm_lb_rule" "my_lb_rule" {
  loadbalancer_id                = azurerm_lb.my_lb.id
  name                           = "iaas-rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  disable_outbound_snat          = true
  frontend_ip_configuration_name = "frontend-ip-iaas"
  probe_id                       = azurerm_lb_probe.my_lb_probe.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.my_lb_pool.id]
}

