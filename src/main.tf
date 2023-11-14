locals {
  chart_version = "0.6.1"
  release       = var.md_metadata.name_prefix
}

resource "random_password" "api-key" {
  length           = 128
  special          = true
  override_special = "!@#$%^&*()_+-="
}

resource "helm_release" "qdrant" {
  name             = local.release
  chart            = "qdrant"
  repository       = "https://qdrant.github.io/qdrant-helm"
  version          = local.chart_version
  namespace        = var.namespace
  create_namespace = true

  values = [
    "${file("${path.module}/values.yaml")}",
    yamlencode(local.helm_values)
  ]

  depends_on = [random_password.api-key]
}
