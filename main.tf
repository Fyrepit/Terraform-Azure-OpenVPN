# main.tf

# Create resource group
resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg"
  location = var.location

  tags = {
    environment = "OpenVPN"
  }
}