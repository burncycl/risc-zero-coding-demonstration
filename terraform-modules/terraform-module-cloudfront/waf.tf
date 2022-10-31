resource "aws_wafv2_ip_set" "ip_whitelist" {
  name               = "${local.id}-ip-whitelist"
  scope              = "CLOUDFRONT"
  ip_address_version = "IPV4"
  addresses          = var.whitelist_ips
}

resource "aws_wafv2_web_acl" "firewall" {
  name = "${local.id}-waf"
  scope = "CLOUDFRONT"

  default_action {
    block {}
  }

  rule {
    name     = "ip-whitelist"
    priority = 1

    action {
      allow {}
    }

    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.ip_whitelist.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "WhitelistedIP"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "Allowed"
    sampled_requests_enabled   = true
  }
}
