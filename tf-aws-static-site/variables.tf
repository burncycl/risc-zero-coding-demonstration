variable "deploy_role" {
  default = "arn:aws:iam::351484734788:role/automation-role"
}

# Project variables
variable "account_id" {}
variable "region" {}
variable "environment" {}
variable "bucket_name" {}
variable "acl" {}
variable "object" {}

