provider "aws" {
  region  = var.region
  profile = var.account
  default_tags {
    tags = module.required_tags.tags
  }
}

module "required_tags" {
  source            = "../terraform-modules/terraform-modules-aws-tags/"
  billing           = "cicd"
  environment       = var.environment
  managed_by        = "terraform"
  owner             = "devops"
  pipeline_repo_url = "http://risc-zero-drqrtx@git.codesubmit.io/risc-zero/aws-deploy-ipcted"
  product           = "demonstration"
  additional_tags = {
    POC = "michael grate"
  }
}

