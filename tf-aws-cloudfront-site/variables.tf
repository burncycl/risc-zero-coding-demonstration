variable "deploy_role" {
  default = "arn:aws:iam::351484734788:role/automation-role"
}

# Project variables
variable "account_id" {}
variable "region" {}
variable "domain_name" {}

variable "environment" {}

# Application variables
variable "application" {}

# Route 53
variable "dns_zone" {}

variable "log_retention" {}

variable "default_origin" {}
variable "origins" { type = map(map(string)) }
variable "root_object" { default = "" }
variable "whitelist_ips" {
  type    = list(string)
  default = []
}
