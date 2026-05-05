provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "final-project-rg"
  location = "East US"
}

# Container Instance
resource "azurerm_container_group" "app" {
  name                = "final-app"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"

  ip_address_type = "Public"
  dns_name_label  = "rohansubba-final-app"  # MUST BE UNIQUE

  container {
    name   = "myapp"
    image  = "nginx"   # TEMP: guaranteed to work
    cpu    = "1"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }

  exposed_port {
    port = 80
  }
}

# OUTPUT URL
output "app_url" {
  value = "http://${azurerm_container_group.app.fqdn}"
}