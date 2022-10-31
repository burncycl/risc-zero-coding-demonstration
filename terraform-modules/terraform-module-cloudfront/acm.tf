
# ACM Certificate
resource "aws_acm_certificate" "certificate" {
  domain_name       = "${var.domain_name}.${data.aws_route53_zone.zone.name}"
  validation_method = "DNS"

  tags = local.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "validation" {
  certificate_arn         = aws_acm_certificate.certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.certificate : record.fqdn]
}
