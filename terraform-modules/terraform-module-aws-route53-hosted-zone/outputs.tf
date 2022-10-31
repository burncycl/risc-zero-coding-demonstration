

output "zone_name_servers" {
  description = "Zone Name Servers"
  value       = flatten(aws_route53_zone.default.name_servers)
}

output "certificate_arn" {
  description = "ACM SSL Certificate ARN"
  value       = var.create_certificate ? aws_acm_certificate.default[0].arn : ""
}

output "zone_id" {
  description = "Zone ID"
  value       = aws_route53_zone.default.zone_id
}

output "zone_name" {
  description = "Zone name"
  value       = var.domain
}
