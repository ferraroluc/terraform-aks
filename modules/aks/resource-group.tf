resource "azurerm_resource_group" "project-rg-aks" {
  name     = "project-${var.environment}-rg-aks"
  location = "East US"

  tags = {
    Environment = var.environment
  }
}