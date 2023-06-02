resource "azurerm_virtual_network" "project-virtualnetwork" {
  name                = "project-${var.environment}-virtualnetwork"
  location            = azurerm_resource_group.project-rg-aks.location
  resource_group_name = azurerm_resource_group.project-rg-aks.name
  address_space       = var.subnet

  tags = {
    Environment = var.environment
  }
}

resource "azurerm_subnet" "project-subnet-aks" {
  name                 = "project-${var.environment}-subnet-aks"
  resource_group_name  = azurerm_resource_group.project-rg-aks.name
  virtual_network_name = azurerm_virtual_network.project-virtualnetwork.name
  address_prefixes     = var.subnet
}

resource "azurerm_public_ip" "project-publicip-aks" {
  name                = "project-${var.environment}-publicip-aks"
  resource_group_name = azurerm_kubernetes_cluster.project-aks-cluster.node_resource_group
  location            = azurerm_resource_group.project-rg-aks.location
  allocation_method   = "Static"
  sku                 = "Standard"
}