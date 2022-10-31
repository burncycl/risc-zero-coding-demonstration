resource "aws_s3_bucket" "origin_bucket" {
  for_each = var.origins
  bucket   = each.value.bucket
  tags     = local.tags
}

resource "aws_s3_bucket_policy" "origin_bucket" {
  for_each = var.origins
  bucket   = aws_s3_bucket.origin_bucket[each.key].id
  policy   = data.aws_iam_policy_document.s3_policy[each.key].json
}

resource "aws_s3_bucket_versioning" "origin_bucket" {
  for_each = var.origins
  bucket   = aws_s3_bucket.origin_bucket[each.key].id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_acl" "origin_bucket" {
  for_each = var.origins
  bucket   = aws_s3_bucket.origin_bucket[each.key].id
  acl      = "private"
}

resource "aws_s3_bucket_website_configuration" "origin_bucket" {
  for_each = var.origins
  bucket   = aws_s3_bucket.origin_bucket[each.key].id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_public_access_block" "bucket" {
  for_each = var.origins
  bucket   = aws_s3_bucket.origin_bucket[each.key].id

  block_public_acls   = true
  block_public_policy = true
  //ignore_public_acls      = true
  //restrict_public_buckets = true
}

resource "aws_s3_bucket_cors_configuration" "bucket" {
  for_each = var.origins
  bucket   = aws_s3_bucket.origin_bucket[each.key].id

  cors_rule {
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["*"]
  }
}

resource "aws_s3_bucket" "logging" {
  bucket = "${var.application}-${var.environment}-logging"
  tags   = local.tags
}

resource "aws_s3_bucket_acl" "logging" {
  bucket = aws_s3_bucket.logging.id
  access_control_policy {
    grant {
      grantee {
        id   = data.aws_canonical_user_id.current.id
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }

    # Grant CloudFront logs access to your Amazon S3 Bucket
    # https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/AccessLogs.html#AccessLogsBucketAndFileOwnership
    grant {
      grantee {
        id   = "c4c1ede66af53448b93c283ce9448c4ba468c9432aa01d700d3878632f77d2d0"
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }

    grant {
      grantee {
        type = "Group"
        uri  = "http://acs.amazonaws.com/groups/s3/LogDelivery"
      }
      permission = "READ_ACP"
    }

    owner {
      id = data.aws_canonical_user_id.current.id
    }
  }
}

resource "aws_s3_bucket_public_access_block" "logging" {
  bucket = aws_s3_bucket.logging.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "logging" {
  bucket = aws_s3_bucket.logging.id

  rule {
    id = "expire"
    expiration {
      days                         = var.log_retention
      expired_object_delete_marker = false
    }
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "logging" {
  bucket = aws_s3_bucket.logging.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "logging" {
  bucket = aws_s3_bucket.logging.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}
