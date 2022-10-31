## 2022/10 Michael Grate

Creates Route53 Hosted Zone per configuration.

## Create Hosted Zone
Push button magic with
```
make hostedzone WORKSPACE=dev
```

## Destroy Hosted Zone
Destroy requires terraform.tfstate

Destroy
```
make destroy WORKSPACE=dev
```

Destroy without prompting. Warning: Very impactful!
```
make destroy_hostedzone WORKSPACE=dev
```

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_required_tags"></a> [required\_tags](#module\_required\_tags) | ../terraform-modules/terraform-module-aws-tags/ | n/a |
| <a name="module_route53_hosted_zone"></a> [route53\_hosted\_zone](#module\_route53\_hosted\_zone) | ../terraform-modules/terraform-module-aws-route53-hosted-zone/ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account"></a> [account](#input\_account) | n/a | `any` | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `any` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `any` | n/a | yes |

## Outputs

No outputs.

