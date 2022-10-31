## 2022/10 Michael Grate

Terrafrom Module for creating a Route53 Hosted Zone.

Example
```
module "route53_hosted_zone" {
  source = "../terraform-modules/terraform-module-aws-route53-hosted-zone/"
  domain = var.domain
}
```

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_route53_record.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_certificate"></a> [create\_certificate](#input\_create\_certificate) | Create an ACM certificate associated with the domain | `bool` | `true` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | Domain for hosted zone | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name tag to apply (will default to `external_domain` if not specified) | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags to add to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_certificate_arn"></a> [certificate\_arn](#output\_certificate\_arn) | ACM SSL Certificate ARN |
| <a name="output_zone_id"></a> [zone\_id](#output\_zone\_id) | Zone ID |
| <a name="output_zone_name"></a> [zone\_name](#output\_zone\_name) | Zone name |
| <a name="output_zone_name_servers"></a> [zone\_name\_servers](#output\_zone\_name\_servers) | Zone Name Servers |

