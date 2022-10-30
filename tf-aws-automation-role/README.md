### 2022/10 Michael Grate

Deploys DevOps Automation IAM role for users to assume.

In an effort to adhear to best-practices, henceforth we'll use a role assumption for all subsequent automation.


## Create Role
Push button magic with
```
make role WORKSPACE=dev
```

All subsequent automation can utilize the following role assumption in the provider block.
```
provider "aws" {
  region                        = var.region
  profile                       = var.account
  assume_role {
    role_arn                    = var.deploy_role
    session_name                = "Deploy_tf"
  }
  default_tags {
    tags = module.required_tags.tags
  }
}
```

Deployment role variables
```
variable "region" {
  default       =       "us-west-2"
}

variable "account" {
  default       =       "default"
}

# Role managed by tf-aws-automation-role 
variable "deploy_role" {
  default      =       "arn:aws:iam::351484734788:role/automation-role"
}
```


## Destroy Role 
Destroy requires terraform.tfstate

Destroy
```
make destroy WORKSPACE=dev
```

Destroy without prompting. Warning: Very impactful!
```
make destroy_role WORKSPACE=dev
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.37.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.37.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account"></a> [account](#input\_account) | n/a | `string` | `"default"` | no |
| <a name="input_automation_role"></a> [automation\_role](#input\_automation\_role) | Automation Role for EC2, SSM, S3, etc. | `string` | `"automation-role"` | no |
| <a name="input_aws_tags"></a> [aws\_tags](#input\_aws\_tags) | n/a | `map` | <pre>{<br>  "billing": "cicd",<br>  "environment": "dev",<br>  "managed-by": "terraform",<br>  "owner": "devops",<br>  "poc": "michael grate",<br>  "product": "demonstration"<br>}</pre> | no |
| <a name="input_policy_arn"></a> [policy\_arn](#input\_policy\_arn) | n/a | `list` | <pre>[<br>  "arn:aws:iam::aws:policy/AmazonEC2FullAccess",<br>  "arn:aws:iam::aws:policy/AmazonVPCFullAccess",<br>  "arn:aws:iam::aws:policy/AmazonSSMFullAccess",<br>  "arn:aws:iam::aws:policy/AmazonS3FullAccess",<br>  "arn:aws:iam::aws:policy/AmazonRDSFullAccess",<br>  "arn:aws:iam::aws:policy/AmazonRoute53FullAccess",<br>  "arn:aws:iam::aws:policy/IAMFullAccess"<br>]</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"us-west-2"` | no |

## Outputs

No outputs.

