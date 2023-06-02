resource "random_id" "project-logs-ramdonid" {
  keepers = {
    group_name = azurerm_resource_group.project-rg-aks.name
  }

  byte_length = 8
}

resource "azurerm_log_analytics_workspace" "project-logs-workspace-aks" {
  name                = "project-${var.environment}-logs-aks-${random_id.project-logs-ramdonid.hex}"
  location            = azurerm_resource_group.project-rg-aks.location
  resource_group_name = azurerm_resource_group.project-rg-aks.name
  sku                 = "PerGB2018"
}

resource "azurerm_log_analytics_solution" "project-logs-solution-aks" {
  solution_name         = "ContainerInsights"
  location              = azurerm_resource_group.project-rg-aks.location
  resource_group_name   = azurerm_resource_group.project-rg-aks.name
  workspace_resource_id = azurerm_log_analytics_workspace.project-logs-workspace-aks.id
  workspace_name        = azurerm_log_analytics_workspace.project-logs-workspace-aks.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}