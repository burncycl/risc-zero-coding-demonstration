### 2020/10 Michael Grate

Reference: 
- [terraform-aws-remote-state](https://github.com/terra-mod/terraform-aws-remote-state.git)

We're not going to reinvent the wheel here folks. Remote state original code borrowed from the above repo. Modified to use newer Terraform Resources.

## Create Remote State

Push button magic with 
```
make remotestate
```

## Create Backup, since no remote state.

Because the remote state doesn't have a remote state of it's own (Inception, ikr?), only local. It should be backed-up once created for good measure.
```
make backup
```

## Destroy Remote State
Destroy requires terraform.tfstate 

Destroy
```
make destroy
```

Destroy without prompting. Warning: Very impactful!
```
make destroy_remotestate
``` 

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.37.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_iam_access_key.key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_role.role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_user.user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy.user_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy) | resource |
| [aws_kms_alias.alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_s3_bucket.logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_acl.state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_logging.state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_logging) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_caller_identity.self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assume_role_principals"></a> [assume\_role\_principals](#input\_assume\_role\_principals) | A set of principals that are allowed to assume the role for managing Terraform State. | `set(string)` | `[]` | no |
| <a name="input_create_user"></a> [create\_user](#input\_create\_user) | Whether or not to create an IAM User that has permissions to manage the Terraform Remote State. | `bool` | `false` | no |
| <a name="input_create_user_credentials"></a> [create\_user\_credentials](#input\_create\_user\_credentials) | Whether to generate an AWS IAM Access key for the user - only applicable if `create_user` is set to true. | `bool` | `false` | no |
| <a name="input_pgp_key"></a> [pgp\_key](#input\_pgp\_key) | An optional PGP Encryption key for the AWS IAM Access key. | `string` | `null` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix to use for S3 buckets, since names are globally unique. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map` | <pre>{<br>  "billing": "cicd",<br>  "environment": "all",<br>  "managed-by": "terraform",<br>  "owner": "devops",<br>  "poc": "michael grate",<br>  "product": "demonstration"<br>}</pre> | no |
| <a name="input_user_name"></a> [user\_name](#input\_user\_name) | The name of the user generated to manage Terraform Remote State - only applicable if `create_user` is set to true. | `string` | `"terraform-remote-state"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket"></a> [bucket](#output\_bucket) | The name of the S3 Bucket used for Terraform Remote State. |
| <a name="output_credentials"></a> [credentials](#output\_credentials) | The IAM Access Key and Secret of the user, if it was opted to generate the credentials. |
| <a name="output_dynamodb"></a> [dynamodb](#output\_dynamodb) | The DynamoDB Table used for locking the Remote State. |
| <a name="output_example_backend_configuration"></a> [example\_backend\_configuration](#output\_example\_backend\_configuration) | Provides an example of what the `backend` configuration would look like in order to use the provisioned Remote State |
| <a name="output_region"></a> [region](#output\_region) | The AWS Region the Terraform Remote State resources are in. |
| <a name="output_role"></a> [role](#output\_role) | The ARN of the IAM Role that is used to access the Remote State |
| <a name="output_user"></a> [user](#output\_user) | The name of the User generated to manage the Remote State. |

