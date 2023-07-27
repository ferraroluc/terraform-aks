resource "azurerm_kubernetes_cluster" "project-aks-cluster" {
  name                = "project-${var.environment}-aks-cluster"
  location            = azurerm_resource_group.project-rg-aks.location
  resource_group_name = azurerm_resource_group.project-rg-aks.name
  dns_prefix          = "project-${var.environment}-aks-cluster"

  kubernetes_version = "1.26.3"
  
  default_node_pool {
    name           = "akspool"
    node_count     = 3
    vm_size        = "Standard_DS2_v2"
    vnet_subnet_id = azurerm_subnet.project-subnet-aks.id
  }

  identity {
    type = "SystemAssigned"
  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.project-logs-workspace-aks.id
  }

  tags = {
    Environment = var.environment
  }
}

resource "kubernetes_namespace" "environment" {
  metadata {
    name = var.environment
  }
}
