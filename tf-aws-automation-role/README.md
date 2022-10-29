### 2022/10 Michael Grate

Deploys DevOps Automation IAM role for automation (e.g. Terraform) to assume. 

In an effort to adhear to best-practices, henceforth we'll use a role assumption for all subsequent automation.


## Create Role
Push button magic with
```
make role
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

# Role managed by tf-iam-automation-user-policy 
variable "deploy_role" {
  default      =       "arn:aws:iam::351484734788:role/automation-role"
}
```


## Destroy Role 
Destroy requires terraform.tfstate

Destroy
```
make destroy
```

Destroy without prompting. Warning: Very impactful!
```
make destroy_role
```

