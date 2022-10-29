# 2022/10 Michael Grate

SHELL := /bin/bash

# Verify we have what we need.
ifeq (, $(shell which terraform))
$(error Terraform Installation Not Found!)
else
export TERRAFORM := $(shell which terraform)
endif

# Declare variables, not war.
REMOTE_STATE_MODULE := tf-aws-remotes-state-backend-s3

# Handle no targets specified.
all:
	$(info make remotestate)
	$(error No target specified.)


remotestate: init fmt validate plan apply notification
destroy_remotestate: init validate destroy_noask


# Silently remove old terraform init. Surpress errors.
clean:
	@rm -rf ./.terraform ||:
	@rm -rf ./terraform.tfstate.backup ||:
	@rm -rf ./terraform.tfstate ||:
	@rm -rf ./.terraform.lock.hcl ||:


# Backup this terraform instance / state, because we do not have a remote state for this piece of automation.
backup: 
	$(info [INFO] Creating Backup of this remote state being executed.) 
	mkdir -p ../../tf-backup
	cd .. && tar czf ../tf-backup/$(REMOTE_STATE_MODULE).tgz $(REMOTE_STATE_MODULE)/


# Terraform
init:
	$(TERRAFORM) init

fmt:
	$(TERRAFORM) fmt 

validate:
	$(TERRAFORM) validate

plan:
	$(TERRAFORM) plan

apply:
	$(TERRAFORM) apply -auto-approve

destroy:
	$(TERRAFORM) destroy

destroy_noask: # WARNING: Extremely impactful!
	$(TERRAFORM) destroy -auto-approve


notification:
	$(info [IMPORTANT] Be sure to note the above outputs, as they will be required for all subsequent automation.) 
