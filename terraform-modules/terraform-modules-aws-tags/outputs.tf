locals {
  date_created = var.include_date_created ? {DateCreated  = time_static.date_created.rfc3339 } : {}
}
output "tags" {
  value = merge({
    Billing             = var.billing
    Environment         = var.environment
    ManagedBy           = var.managed_by
    Owner               = var.owner
    PipelineRepoUrl     = var.pipeline_repo_url
    Product             = var.product 
  },
  var.additional_tags,
  local.date_created
  )
  description = "A map of the generated tags."
}

resource "time_static" "date_created" {}