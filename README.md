## 2022/10 Michael Grate

Coding demonstration for Risc Zero with love <3.

Finished Product can be reached by pointing your browser to 
- https://risczerodemonstration.s3.us-west-2.amazonaws.com/index.html

This is provided your IP Space is either `3.121.56.176/32` (requirement by the original documentation) or `75.166.43.168/32` (my personal IP space).

## Summary of project from Original README.md

[Original_README.md](./Original_README.md)

Objective:

Your assignment is to build a terraform configuration that sets up hosting
for the provided index.html file.

- Implement a terraform configuration to create the required infrastructure on AWS.
- Use terraform to 'deploy' the index.html ( application ) on the AWS infrastructure.
- Ensure that the application can only be accessed from: 3.121.56.176

Requirements:
- Terraform best practices.
- Choice of infrastructure
- Completeness: did you complete the features?
- Correctness: does the functionality act in sensible, thought-out ways?
- Maintainability: is it written in a clean, maintainable way?


## Best Practices Employed

- Proper documentation everywhere. I'm big on Documentation! Back in high-school, Tim got me using Mediawiki for all my documentation. I use Documentation + Automation as a conduit for all my work.
- Docker local development is an entrypoint for the automation. Because it always "works on my machine". But, the next poor developer doesn't have your machine! We'll use Docker to hopefully eliminate this issue (this is a newer pattern - It still has it's issues, which I can discuss).
- Ansible Local Development automation is also avaiable for folks (like me) who don't like running in containers, but rather a native Linux environment. 
- Implemented Terraform Remote State. Because local state is too cheap and easy for a proper system.
- Utilized `Makefile` for simplified push button execution. Detects dependencies and fails fast if there is an issue. `Make` is superior to shell scripts for bubbling up exit code statuses. I don't shell script `set -e` and functions. `Make` Adds flexibility in that it can chain dependencies or call the single part of a larger build. 
- Implemented roles for all subsequent automation, because hard-code credentials are gross. SSO + Roles FTW! 
- Terraform automation utilizes workspaces to define various environments. For now, we only support `dev`.
- Terraform automation utilizes Tagging module. Tagging standards are important so we can easily identify resources in AWS. It's best practice to put these standards in-place early so everything is accounted. This also lends itself to automation later that can utilize tags like "monkey scripts" that shut stuff down based on tags for cost savings.
- Tests. We test our code, and we help support testing.

## Getting Started
You have two options, for your development environment

- Use a Dockerized environment (because it always, "works on my machine") to deploy subsquent code.
- Use Ubuntu for your development environment. Ansible will provision your local system in a pure fashion. 

### Prerequisites

Install Docker on your Platform

- [Install Docker Desktop on Windows](https://docs.docker.com/desktop/install/windows-install/)
- [Install Docker Desktop on Mac](https://docs.docker.com/desktop/install/mac-install/)
- [Install Docker Desktop on Linux](https://docs.docker.com/desktop/install/linux-install/)
- [Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)

Internet search for your specific platform and `Docker Install` to get more clear references.

Once Docker is installed, to build Dockerized local development environment use,
```
docker build -t aws-deploy-ipcted:latest .
```
This will produce an image on your local system called `aws-deploy-ipcted:latest` to be used henceforth for local development for this project.

### Local Development Environment using Docker (docker-ctl)
Note: This script is multi-platform compliant. Using this pattern is still fairly new and under heavy development.


Instantiate local development
```
./docker-ctl start
``` 
Note: This script is multi-platform compliant.

Help
```
./docker-ctl help
```

Additional options
```
./docker-ctl [build/start/stop/clean]
```

`docker-ctl`  will mount the following into the Dockerized Dev environment.
- This Project directory
- AWS Credentials + Config `~/.aws`
- SSH Keys `~/.ssh`
- Git Configuration `~/.gitconfig`

### Local Development Environment using pure Ubuntu (no Docker) with Ansible 
This assumes you want a pure system (non-dockerized). I typically use Ubuntu based Linux systems for development. This is the oldie, but goodie way of managing a base development environment.

What's cool about this automation, is it allows you to store you secrets (e.g. AWS Cloud credentials + ssh keys) in source control. This also version controls your local development environment. No Dockerized overhead.

Prerequisites
```
sudo apt-add-repository universe
sudo apt update
sudo apt install -y git ansible make
```

Provision local development with environment. 
```
make local_dev WORKSPACE=dev
```
Additionally, check out [README.md](./ansible-local-development-environment/README.md)

## Terraform Docs Markdown
As new Terraform is created, we want to automate aspects of our documentation output. So, we'll use `terraform-docs` output and append it to our `README.md`

Thus, inside a Terraform project, run
```
terraform-docs markdown .
```
Take the output and put it in the `README.md`.

## Trials and Tribulations
I had industrious dreams of setting up a Cloudfront site. But, AWS is stuck `Pending validation` on the certificate. The Route53 records are in-place. This is just the nature of the beast. That said, we went with the KISS solution. But, should your website really take-off, all the stuff is here for a highly scalable Cloudfront site.

![AWS](img/pending_validation.png?raw=true "AWS Pending Validation")

Thus, I have divided the deployment into two phases. 

- Phase 1 - KISS solution using a basic S3 bucket with policy permissions.
- Phase 2 - Cloudfront site using hosted zone on Route 53. 

## Deployments
These are the various deployment entry points. For simplicy you can start in the root of the project and deploy `phase1` or `phase2` from `Makefile`.

One can also drill into the invidual module components and execute the automation there, as well.

## Deploy Everything - Phase 1 
Push button magic with
```
make phase1 WORKSPACE=dev 
```

## Deploy Everything - Phase 2
Push button magic with
```
make phase2 WORKSPACE=dev
```

## Deploy Individual Resources (from parent) 
## Deploy Terraform Remote State (one and done)
Push button magic with
```
make remotestate
```
This will Create a remote state bucket. Additionally, it will backup the remote state locally to a tarball for good measure beyond just commiting `terraform.tfstate` to source control.

### Deploy Automation Role
Push button magic with

```
make role WORKSPACE=dev
```

### Deploy S3 Static Site (KISS)
Push button magic with
```
make site WORKSPACE=dev
```

### Deploy Hosted Zone
Push button magic with
```
make hostedzone WORKSPACE=dev
```

### Deploy Cloudfront Site
Push button magic with
```
make cf WORKSPACE=dev
```

## Test Code
```
make test WORKSPACE=dev
```
