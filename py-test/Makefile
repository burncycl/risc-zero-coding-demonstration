# 2022/10 Michael Grate

# Setup Python virtual envrionment.
ifeq (, $(shell which python3))
$(error Python3 Installation Not Found!)
else
export PYTHON3_LOCAL := $(shell which python3)
endif
ifeq (, $(shell which virtualenv))
$(error Python Virtual Environment Installation Not Found!)
else
export VENV := $(shell which virtualenv)
endif
$(info Creating Virtual Environment...)
VENV_NAME := venv
CREATE_VENV3 := $(shell ${VENV} -p python3 ./${VENV_NAME})
VENV_ACTIVATE := ./${VENV_NAME}/bin/activate
PYTHON3 := ./${VENV_NAME}/bin/python3
PIP3 := ./${VENV_NAME}/bin/pip3
REQUIREMENTS := $(shell ${PIP3} install -r ./requirements.txt)
ANSIBLE_PLAYBOOK := ./${VENV_NAME}/bin/ansible-playbook
J2 := ./${VENV_NAME}/bin/j2
$(info Virtual Environment Created.)

TEST_FILE := tests.py

tests: test
test:
	$(PYTHON3) $(TEST_FILE)

clean:
	@rm -rf ./venv ||:
