# 2022/10 Michael Grate

# Verify we have what we need.
ifeq (, $(shell which make))
$(error Make Installation Not Found!)
else
export MAKE := $(shell which make)
endif

# Declare variables, not war.
REMOTE_STATE_DIR := ./tf-aws-remotes-state-backend-s3
LOCAL_DEV_ENV_DIR := ./ansible-local-development-environment

# Provision Local Development Environment
	cd $(LOCAL_DEV_ENV_DIR) && $(MAKE)  

# Remote State (one and done)
remotestate:
	$(info This will Create a Remote State Bucketh DynamoDB Locking and Backup the State to a tarball because this is the inception of Terraform automation, there is no held state for Remote State.)
	cd $(REMOTE_STATE_DIR) && $(MAKE) remotestate
	cd $(REMOTE_STATE_DIR) && $(MAKE) backup


