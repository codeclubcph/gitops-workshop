variable "kubeconfig_path" {
  description = "Path to kubeconfig"
  type        = string
  default     = "~/.kube/config"
}

variable "namespaces" {
  description = "Namespaces to create"
  type        = list(string)
  default     = ["demo-dev", "demo-prod"]
}
