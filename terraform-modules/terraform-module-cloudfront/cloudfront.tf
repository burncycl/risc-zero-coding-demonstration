

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "${var.application}2-${var.environment}-cloudfront-access-identity"
}

resource "aws_cloudfront_distribution" "cdn" {
  #
  dynamic "origin" {
    for_each = var.origins
    content {
      domain_name = aws_s3_bucket.origin_bucket[origin.key].bucket_regional_domain_name
      origin_id   = "${origin.key}-S3origin"

      s3_origin_config {
        origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
      }
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = var.root_object
  web_acl_id          = tobool(length(var.whitelist_ips) > 0) ? aws_wafv2_web_acl.firewall.arn : null

  aliases = ["${var.domain_name}.${data.aws_route53_zone.zone.name}"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "${var.default_origin}-S3origin"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy     = "redirect-to-https"
    min_ttl                    = 0
    default_ttl                = 3600
    max_ttl                    = 86400
    response_headers_policy_id = aws_cloudfront_response_headers_policy.cors.id
  }

  dynamic "ordered_cache_behavior" {
    for_each = var.origins
    content {
      path_pattern = "${var.origins[ordered_cache_behavior.key]["path"]}*"

      allowed_methods  = ["GET", "HEAD"]
      cached_methods   = ["GET", "HEAD"]
      target_origin_id = "${ordered_cache_behavior.key}-S3origin"

      forwarded_values {
        query_string = false
        cookies {
          forward = "none"
        }
      }

      viewer_protocol_policy     = "redirect-to-https"
      default_ttl                = 0
      min_ttl                    = 0
      max_ttl                    = 0
      response_headers_policy_id = aws_cloudfront_response_headers_policy.cors.id
    }
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = local.tags

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn            = aws_acm_certificate.certificate.arn
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.2_2021"
  }

  logging_config {
    include_cookies = false
    bucket          = aws_s3_bucket.logging.bucket_domain_name
    prefix          = "${var.application}-${var.environment}-logging"
  }
}

resource "aws_cloudfront_response_headers_policy" "cors" {
  name = "${local.id}-policy"
  cors_config {
    access_control_allow_credentials = false
    access_control_allow_headers {
      items = ["*"]
    }
    access_control_allow_methods {
      items = ["GET", "HEAD", "OPTIONS"]
    }
    access_control_allow_origins {
      items = ["*"]
    }
    origin_override = true
  }
}
