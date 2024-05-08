.PHONY: all packer terraform

all: help

# Add the following 'help' target to your Makefile
# And add help text after each target name starting with '\#\#'

help:						## Show this help
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

packer: ## Run packer build
	source */.env && cd packer && $(MAKE) deploy

init:		readenv
	terraform init
plan:		readenv		## Plan the changes to infra.
	terraform plan

apply:		readenv		## Apply the changes in plan.
	terraform apply

output:		readenv		## See the output.
	terraform output -json

destroy:	readenv		## Destroy the infra.
	terraform destroy

readenv:
	source */.env