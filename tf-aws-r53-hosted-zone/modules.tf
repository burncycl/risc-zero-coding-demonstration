module "route53_hosted_zone" {
  source = "../terraform-modules/terraform-module-aws-route53-hosted-zone/"
  domain = var.domain
}
