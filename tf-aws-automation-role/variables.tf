variable "region" {
  default = "us-west-2"
}

variable "account" {
  default = "default"
}

variable "environment" {
  default = "dev"
}

# Automation Role for EC2, SSM, S3, etc.
variable "automation_role" {
  default = "automation-role"
}

variable "policy_arn" {
  default = ["arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/AmazonVPCFullAccess",
    "arn:aws:iam::aws:policy/AmazonSSMFullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/AmazonRDSFullAccess",
    "arn:aws:iam::aws:policy/AmazonRoute53FullAccess",
  "arn:aws:iam::aws:policy/IAMFullAccess"]
}

variable "aws_tags" {
  default = {
    environment = "dev"
    billing     = "cicd"
    owner       = "devops"
    product     = "demonstration"
    managed-by  = "terraform"
    poc         = "michael grate"
  }
}


