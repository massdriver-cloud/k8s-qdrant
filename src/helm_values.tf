locals {
  helm_values = {
    nameOverride = var.md_metadata.name_prefix
    podLabels    = var.md_metadata.default_tags
    replicaCount = var.database.replica_configuration.replicas
    resources = {
      requests = {
        cpu    = var.database.instance_configuration.cpu_limit / 2
        memory = ceil(var.database.instance_configuration.memory_limit / 2)
      }
      limits = {
        cpu    = var.database.instance_configuration.cpu_limit
        memory = var.database.instance_configuration.memory_limit
      }
    }
    persistence = {
      size = "${var.database.instance_configuration.storage_size}Gi"
    }
    apiKey = random_password.api-key.result
  }
}
