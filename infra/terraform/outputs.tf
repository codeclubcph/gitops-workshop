output "namespaces_created" {
  value = [for ns in kubernetes_namespace.env : ns.metadata[0].name]
}
