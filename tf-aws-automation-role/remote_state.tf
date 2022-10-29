terraform {
  required_version = ">= 1.1.0"
  required_providers {
    aws = ">= 4.37.0"
  }

  backend "s3" {
    encrypt        = true
    bucket         = "demonstration-tf-remote-state"
    dynamodb_table = "demonstration-tf-remote-state"
    role_arn       = "arn:aws:iam::351484734788:role/terraform-remote-state/tf-state-management"
    key            = "dev/automation-role"
    region         = "us-west-2"
  }
}

