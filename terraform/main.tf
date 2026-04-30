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

  container {
    name   = "myapp"
    image  = var.docker_image
    cpu    = "1"
    memory = "1.5"

    ports {
      port     = 8000
      protocol = "TCP"
    }
  }

  ip_address_type = "public"

  exposed_port {
    port = 8000
  }
}