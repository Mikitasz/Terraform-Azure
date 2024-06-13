resource "azurerm_container_group" "container" {
  name                = "paas-app"
  location            = var.rg_location
  resource_group_name = var.rg_name
  ip_address_type     = "Public"
  os_type             = "Linux"

  container {
    name   = "paas-container-app"
    image  = "ghcr.io/karakean/text-to-speech-demo-app"
    cpu    = 0.25
    memory = 0.5

    ports {
      port     = 8080
      protocol = "TCP"
    }

  }
  image_registry_credential {
    username = "mikitasz"
    server   = "ghcr.io"
  }
}
output "container_ipv4_address" {
  value = azurerm_container_group.container.ip_address
}
