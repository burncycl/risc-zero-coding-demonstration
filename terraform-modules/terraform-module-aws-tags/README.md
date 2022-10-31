## 2022/10 Michael Grate

Terraform automation utilizes Tagging module. Tagging standards are important so we can easily identify resources in AWS. It's best practice to put these standards in-place early so everything is accounted. This also lends itself to automation later that can utilize tags like "monkey scripts" that shut stuff down based on tags fo
r cost savings.

Note: Not everyting is going to play nice with `default_tags` defined. That said, you may need to apply this module to individual resources.

Example with a provider block
```
provider "aws" {
  region  = var.region
  profile = var.account
  default_tags {
    tags = module.required_tags.tags
  }
}

module "required_tags" {
  source            = "../terraform-modules/terraform-module-aws-tags"
  billing           = "cicd"
  environment       = var.environment
  managed_by        = "terraform"
  owner             = "devops"
  pipeline_repo_url = "http://risc-zero-drqrtx@git.codesubmit.io/risc-zero/aws-deploy-ipcted"
  product           = "demonstration"
  additional_tags = {
    poc = "michael grate"
  }
}
```

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [time_static.date_created](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tags"></a> [additional\_tags](#input\_additional\_tags) | (Optional) Additional tags to add to resources. | `map(string)` | `{}` | no |
| <a name="input_billing"></a> [billing](#input\_billing) | Represents a product team (E.g. globalgateway, idv, docv, bankv, etc.) or auxiliary team that is accountable for the cost incurred. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Products/services belong to either dev, qa, staging or prod. Consult the DevOps team before using a custom value. | `string` | n/a | yes |
| <a name="input_include_date_created"></a> [include\_date\_created](#input\_include\_date\_created) | (Optional) a boolean flag to include a dated-time stamp tag. Defaults to false as including a dynamic value in a tag can cause issues on first creation of certain resources. | `bool` | `false` | no |
| <a name="input_managed_by"></a> [managed\_by](#input\_managed\_by) | Identifies how the resource were created (E.g. terraform, manual, ansible, etc.) | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input\_owner) | The entity that is responsible for administering and managing the resource. This may or may not be the group/team that provisioned the resource. | `string` | n/a | yes |
| <a name="input_pipeline_repo_url"></a> [pipeline\_repo\_url](#input\_pipeline\_repo\_url) | The URL location of the repository that contains the pipeline deploying the tagged resources. | `string` | n/a | yes |
| <a name="input_product"></a> [product](#input\_product) | The product tag can have a slight overlap with billing tag. Differentiation comes on scenarios when/if a resource is part of a certain product but should be billed under a different product team on a shared or dedicated basis. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_tags"></a> [tags](#output\_tags) | A map of the generated tags. |

