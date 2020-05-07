WANIP=$(shell dig @resolver1.opendns.com ANY myip.opendns.com +short)
PROJECT_NAME=st-2349
CLOUD_PROVIDER=aws
LOGIN_USER=ubuntu

.PHONY: prepare init join all up down update provision provision-aws

prepare:
	gsed -i 's/admin_cidrs = .*/admin_cidrs = ["$(WANIP)\/32"]/' terraform.tfvars

init: prepare
	terraform apply -var init_phase=true
	./init_cluster.sh $(LOGIN_USER)

join:
	terraform apply -var-file=join_vars.tfvars

provision-aws:
	KUBECONFIG=admin.conf kubectl apply -k cluster-resources/aws-base

provision: provision-$(CLOUD_PROVIDER)

up: init join provision

update: join

down:
	terraform destroy
