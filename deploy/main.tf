data "azurerm_client_config" "current" {}

locals {
    resource_name               = var.application_name
    aks_name                    = "${local.resource_name}-aks"
    workload-identity           = "${var.namespace}-utils-identity"
}

data "azurerm_resource_group" "this" {
  name                  = "${local.resource_name}_rg"  
}

data "azurerm_kubernetes_cluster" "this" {
  name                = local.aks_name
  resource_group_name = data.azurerm_resource_group.this.name
}