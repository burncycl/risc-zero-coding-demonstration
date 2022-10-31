## 2022/10 Michael Grate

Creates Static public site on S3.

## Create Site
Push button magic with
```
make bucket WORKSPACE=dev
```

## Destroy Site
Destroy requires terraform.tfstate

Destroy
```
make destroy WORKSPACE=dev
```

Destroy without prompting. Warning: Very impactful!
```
make destroy_bucket WORKSPACE=dev
```

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.37.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_required_tags"></a> [required\_tags](#module\_required\_tags) | ../terraform-modules/terraform-module-aws-tags/ | n/a |
| <a name="module_s3_bucket"></a> [s3\_bucket](#module\_s3\_bucket) | ../terraform-modules/terraform-module-aws-s3-static-site | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_s3_object.object](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | Project variables | `any` | n/a | yes |
| <a name="input_acl"></a> [acl](#input\_acl) | n/a | `any` | n/a | yes |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | n/a | `any` | n/a | yes |
| <a name="input_deploy_role"></a> [deploy\_role](#input\_deploy\_role) | n/a | `string` | `"arn:aws:iam::351484734788:role/automation-role"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `any` | n/a | yes |
| <a name="input_object"></a> [object](#input\_object) | n/a | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `any` | n/a | yes |

## Outputs

No outputs.

