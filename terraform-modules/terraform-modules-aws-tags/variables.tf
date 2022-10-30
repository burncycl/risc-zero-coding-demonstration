variable "additional_tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) Additional tags to add to resources."
}

variable "billing" {
  type        = string
  description = "Represents a product team (E.g. globalgateway, idv, docv, bankv, etc.) or auxiliary team that is accountable for the cost incurred."
}

variable "environment" {
  type        = string
  description = "Products/services belong to either dev, qa, staging or prod. Consult the DevOps team before using a custom value."
}

variable "include_date_created" {
  type        = bool
  description = "(Optional) a boolean flag to include a dated-time stamp tag. Defaults to false as including a dynamic value in a tag can cause issues on first creation of certain resources."
  default     = false
}

variable "managed_by" {
  type        = string
  description = "Identifies how the resource were created (E.g. terraform, manual, ansible, etc.)"
}

variable "owner" {
  type        = string
  description = "The entity that is responsible for administering and managing the resource. This may or may not be the group/team that provisioned the resource."
}

variable "pipeline_repo_url" {
  type        = string
  description = "The URL location of the repository that contains the pipeline deploying the tagged resources."
}
variable "product" {
  type        = string
  description = "The product tag can have a slight overlap with billing tag. Differentiation comes on scenarios when/if a resource is part of a certain product but should be billed under a different product team on a shared or dedicated basis."
}

