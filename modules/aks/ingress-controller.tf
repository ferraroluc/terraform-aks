provider "kubernetes" {
    host                   = azurerm_kubernetes_cluster.project-aks-cluster.kube_config.0.host
    client_certificate     = base64decode(azurerm_kubernetes_cluster.project-aks-cluster.kube_config.0.client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.project-aks-cluster.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.project-aks-cluster.kube_config.0.cluster_ca_certificate)
}

provider "helm" {
    kubernetes {
        host = azurerm_kubernetes_cluster.project-aks-cluster.kube_config.0.host
        client_certificate     = base64decode(azurerm_kubernetes_cluster.project-aks-cluster.kube_config.0.client_certificate)
        client_key             = base64decode(azurerm_kubernetes_cluster.project-aks-cluster.kube_config.0.client_key)
        cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.project-aks-cluster.kube_config.0.cluster_ca_certificate)
    }
}

resource "kubernetes_namespace" "ingress-basic" {
    metadata {
        name = "ingress-basic"
    }
}

resource "helm_release" "ingress-nginx" {
    name             = "ingress-nginx"
    namespace        = kubernetes_namespace.ingress-basic.metadata[0].name
    create_namespace = false
    repository       = "https://kubernetes.github.io/ingress-nginx"
    chart            = "ingress-nginx"

    values = [
    templatefile("${path.module}/configs/ingress-controller.yaml.tpl", {
      public_ip = azurerm_public_ip.project-publicip-aks.ip_address
    })
  ]
}

resource "helm_release" "cert-manager" {
    name             = "cert-manager"
    namespace        = kubernetes_namespace.ingress-basic.metadata[0].name
    create_namespace = false
    repository       = "https://charts.jetstack.io"
    chart            = "cert-manager"
    version          = "v1.8.0"
    
    set {
        name  = "installCRDs"
        value = "true"
    }
}