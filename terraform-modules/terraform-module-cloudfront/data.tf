# AWS account details
data "aws_caller_identity" "current" {}

data "aws_route53_zone" "zone" {
  name     = var.dns_zone
}

data "aws_iam_policy_document" "s3_policy" {
  for_each = var.origins

  statement {
    actions   = ["s3:GetObject"]
    effect    = "Allow"
    resources = ["${aws_s3_bucket.origin_bucket[each.key].arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn]
    }
  }
}

data "aws_canonical_user_id" "current" {}

