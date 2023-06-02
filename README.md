# terraform-aks

A Terraform project that creates a Kubernetes cluster on Azure, using load balancer and certificates.

Instructions for generating the Ingress Controller and TLS certificates were taken from the official Microsoft documentation:

- [Ingress Controller](https://learn.microsoft.com/en-us/azure/aks/ingress-basic?tabs=azure-cli)
- [TLS certificates](https://learn.microsoft.com/en-us/azure/aks/ingress-tls?tabs=azure-cli)

Using this information, the AZ-CLI commands were transformed into Terraform resources and Kubernetes manifests.

## Requirements

This project saves the state of Terraform in an Azure Storage Account. Therefore, it is necessary to create one and generate an `ARM_ACCESS_KEY` that allows the connection.

## Instruccions

If you want to use the `letsencrypt` module, first of all, a Kubernetes cluster must exist. That is why this module is commented in the `main.tf` file. So, you should first run the script as is, and once the cluster is created, uncomment the `letsencrypt` module and run again.

### Commands for DEV environment

```bash
export ARM_ACCESS_KEY="<ACCESS_KEY_VALUE>"
terraform init -backend-config=environments/dev/backend.conf
terraform validate
terraform plan -var-file=environments/dev/main.tfvars
terraform apply -var-file=environments/dev/main.tfvars
```
