# 2022/10 Michael Grate

# Verify we have what we need.
ifeq (, $(shell which terraform))
$(error Terraform Installation Not Found!)
else
export TERRAFORM := $(shell which terraform)
endif

# Check environment variables are set.
ifeq ($(origin WORKSPACE), undefined)
$(error WORKSPACE Variable is Undefined!)
endif


# Handle no targets specified.
all:
	$(info make hostedzone)
	$(error No target specified.)


hostedzone: init fmt validate plan apply
hostedzone_plan: init workspace fmt validate plan
destroy_hostedzone: init validate destroy_noask


# Silently remove old terraform init. Surpress errors.
clean:
	@rm -rf ./.terraform ||:
	@rm -rf ./terraform.tfstate.backup ||:
	@rm -rf ./terraform.tfstate ||:


# Terraform
workspace:
	@echo "Configure terraform workspace to $(WORKSPACE)..."
	@$(TERRAFORM) workspace select $(WORKSPACE) || terraform workspace new $(WORKSPACE)

init:
	$(TERRAFORM) init

fmt:
	$(TERRAFORM) fmt

validate:
	$(TERRAFORM) validate 

plan:
	$(TERRAFORM) plan -var-file="./tfvars/$(WORKSPACE).tfvars"

apply:
	$(TERRAFORM) apply -var-file="./tfvars/$(WORKSPACE).tfvars" -auto-approve

destroy:
	$(TERRAFORM) destroy -var-file="./tfvars/$(WORKSPACE).tfvars"	

destroy_noask: # WARNING: Extremely impactful!
	$(TERRAFORM) destroy -var-file="./tfvars/$(WORKSPACE).tfvars" -auto-approve	

