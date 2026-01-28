terraform {
  required_version = ">= 1.5.0"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.25.0"
    }
  }
}

provider "kubernetes" {
  config_path = var.kubeconfig_path
}

resource "kubernetes_namespace" "env" {
  for_each = toset(var.namespaces)

  metadata {
    name = each.value
    labels = {
      "gitops-workshop" = "true"
      "environment"     = each.value
    }
  }
}

# A small "environment config" ConfigMap per namespace
resource "kubernetes_config_map" "env_config" {
  for_each = toset(var.namespaces)

  metadata {
    name      = "env-config"
    namespace = kubernetes_namespace.env[each.value].metadata[0].name
  }

  data = {
    ENVIRONMENT = each.value
    OWNER       = "gitops-workshop"
  }
}
