output "kube_config" {
  value     = azurerm_kubernetes_cluster.project-aks-cluster.kube_config
  sensitive = true
}

output "public_ip" {
  value     = azurerm_public_ip.project-publicip-aks.ip_address
  sensitive = true
}