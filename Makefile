DIR_GIT=$(shell sh -c "git rev-parse --show-toplevel")

all: help

##@ Docs Generation
doc: README.md ## Generates Terraform docs for modules
	$(call info_colors,blue,📄 Terraform docs)
	@terraform-docs .

##@ Formating
format: ## Runs Terraform fmt and Validate
	terraform fmt
	terraform validate

include $(DIR_GIT)/prettier.mk

.PHONY: all doc format
