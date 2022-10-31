locals {
  bucket_policy = templatefile("${path.module}/templates/s3-policy.tmpl.json", {
    bucket_name = var.bucket_name
    account_id  = var.account_id
  })

}

module "s3_bucket" {
  source      = "../terraform-modules/terraform-module-aws-s3-static-site"
  bucket_name = var.bucket_name
  policy      = local.bucket_policy
  acl         = var.acl
}
