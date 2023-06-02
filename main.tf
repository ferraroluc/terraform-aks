module "aks" {
  source = "./modules/aks"

  environment = var.environment
  subnet      = var.subnet
}

# module "letsencrypt" {
#   source = "./modules/letsencrypt"

#   email = var.email

#   kubernetes_kube_config = module.aks.kube_config
#   kubernetes_public_ip   = module.aks.public_ip
# }