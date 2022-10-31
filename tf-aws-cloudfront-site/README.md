## 2022/10 Michael Grate

Creates Cloudfront site utilizing modules.

## Create Cloudfront
Push button magic with
```
make cf WORKSPACE=dev
```

## Destroy Cloudfront
Destroy requires terraform.tfstate

Destroy
```
make destroy WORKSPACE=dev
```

Destroy without prompting. Warning: Very impactful!
```
make destroy_cf WORKSPACE=dev
```

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudfront-s3"></a> [cloudfront-s3](#module\_cloudfront-s3) | ../terraform-modules/terraform-module-cloudfront/ | n/a |
| <a name="module_required_tags"></a> [required\_tags](#module\_required\_tags) | ../terraform-modules/terraform-module-aws-tags/ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | Project variables | `any` | n/a | yes |
| <a name="input_application"></a> [application](#input\_application) | Application variables | `any` | n/a | yes |
| <a name="input_default_origin"></a> [default\_origin](#input\_default\_origin) | n/a | `any` | n/a | yes |
| <a name="input_deploy_role"></a> [deploy\_role](#input\_deploy\_role) | n/a | `string` | `"arn:aws:iam::351484734788:role/automation-role"` | no |
| <a name="input_dns_zone"></a> [dns\_zone](#input\_dns\_zone) | Route 53 | `any` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | n/a | `any` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `any` | n/a | yes |
| <a name="input_log_retention"></a> [log\_retention](#input\_log\_retention) | n/a | `any` | n/a | yes |
| <a name="input_origins"></a> [origins](#input\_origins) | n/a | `map(map(string))` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `any` | n/a | yes |
| <a name="input_root_object"></a> [root\_object](#input\_root\_object) | n/a | `string` | `""` | no |
| <a name="input_whitelist_ips"></a> [whitelist\_ips](#input\_whitelist\_ips) | n/a | `list(string)` | `[]` | no |

## Outputs

No outputs.

