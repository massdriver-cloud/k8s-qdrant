locals {
  helm_values = {
    nameOverride = var.md_metadata.name_prefix
    podLabels    = var.md_metadata.default_tags
    replicaCount = var.replica_configuration.replicas
    resources = {
      requests = {
        cpu    = "${var.instance_configuration.cpu_limit}"
        memory = "${var.instance_configuration.memory_limit}Gi"
      }
      limits = {
        cpu    = "${var.instance_configuration.cpu_limit}"
        memory = "${var.instance_configuration.memory_limit}Gi"
      }
    }
    apiKey = random_password.api-key.result
  }
}
