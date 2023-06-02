provider "kubernetes" {
  host                   = var.kubernetes_kube_config.0.host
  client_certificate     = base64decode(var.kubernetes_kube_config.0.client_certificate)
  client_key             = base64decode(var.kubernetes_kube_config.0.client_key)
  cluster_ca_certificate = base64decode(var.kubernetes_kube_config.0.cluster_ca_certificate)
}

resource "kubernetes_manifest" "letsencrypt" {
  manifest = yamldecode(templatefile(
    "${path.module}/configs/letsencrypt.yaml.tpl",
    {
      "email" = var.email
    }
  ))
}