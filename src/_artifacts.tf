# locals {
#   data_authentication = {
#     api_key  = random_password.api-key.result
#     hostname = "${local.release}-master.${var.namespace}.svc.cluster.local"
#     port     = 6333
#   }
# }

# resource "massdriver_artifact" "authentication" {
#   field                = "qdrant_authentication"
#   provider_resource_id = "${var.namespace}/${local.data_authentication.hostname}"
#   name                 = "Qdrant at ${var.namespace}/${local.data_authentication.hostname}"
#   artifact = jsonencode(
#     {
#       data = {
#         infrastructure = {
#           kubernetes_service   = local.release
#           kubernetes_namespace = var.namespace
#         }
#         authentication = local.data_authentication
#       }
#       specs = {
#         qdrant = {
#           version = local.chart_version
#         }
#       }
#     }
#   )
# }
