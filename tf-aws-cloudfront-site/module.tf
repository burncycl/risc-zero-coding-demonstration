module "cloudfront-s3" {
  account_id     = var.account_id
  region         = var.region
  domain_name    = var.domain_name
  environment    = var.environment
  aws_tags       = module.required_tags.tags
  application    = var.application
  log_retention  = var.log_retention
  default_origin = var.default_origin
  dns_zone       = var.dns_zone
  origins        = var.origins

  source = "../terraform-modules/terraform-module-cloudfront/"
}

