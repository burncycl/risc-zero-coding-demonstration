# Project variables
variable "account_id" {}
variable "region" {}
variable "domain_name" {}

variable "environment" {}

variable "aws_tags" { type = map(string) }

# Application variables
variable "application" {}

# Route 53
variable "dns_zone" {}

variable "log_retention" {}

variable "default_origin" {}
variable "origins" { type = map(map(string))}
variable "root_object" { default = "" }
variable "whitelist_ips" {
  type = list(string)
  default=[]
}

locals {
  tags = merge({
    Name = "${var.application}-${var.environment}-website-distribution"
    env = var.environment },
    var.aws_tags
  )
}
