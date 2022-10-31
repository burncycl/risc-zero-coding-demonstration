# 2022/10 Michael Grate

# Verify we have what we need.
ifeq (, $(shell which make))
$(error Make Installation Not Found!)
else
export MAKE := $(shell which make)
endif

# Check environment variables are set.
ifeq ($(origin WORKSPACE), undefined)
$(error WORKSPACE Variable is Undefined!)
endif


# Declare variables, not war.
REMOTE_STATE_DIR := ./tf-aws-remotes-state-backend-s3
LOCAL_DEV_ENV_DIR := ./ansible-local-development-environment
AUTOMATION_ROLE_DIR := ./tf-aws-automation-role 
STATIC_SITE_DIR := ./tf-aws-static-site
R53_HOSTED_ZONE_DIR := ./tf-aws-r53-hosted-zone
CLOUDFRONT_SITE_DIR := ./tf-aws-cloudfront-site
TEST_DIR := ./py-test

phase1: remotestate site 
phase2: hostedzone cf

# Remote State (one and done)
remotestate:
	$(info This will Create a Remote State Bucketh DynamoDB Locking and Backup the State to a tarball because this is the inception of Terraform automation, there is no held state for Remote State.)
	cd $(REMOTE_STATE_DIR) && $(MAKE) remotestate
	cd $(REMOTE_STATE_DIR) && $(MAKE) backup


local_dev:
	cd $(LOCAL_DEV_ENV_DIR) && $(MAKE) env

automation_role:
	cd $(AUTOMATION_ROLE_DIR) && $(MAKE) role

site:
	cd $(STATIC_SITE_DIR) && $(MAKE) bucket

hostedzone:
	cd $(R53_HOSTED_ZONE_DIR) && $(MAKE) hostedzone

cf:
	cd $(CLOUDFRONT_SITE_DIR) && $(MAKE) cf

tests: test
test:
	cd $(TEST_DIR) && $(MAKE) test
