.PHONY: help init plan apply configure verify destroy fmt

help: ## Показать список целей
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-10s %s\n", $$1, $$2}'

init: ## terraform init (скачивает провайдер docker)
	cd terraform && terraform init

plan: ## Показать, что изменит Terraform
	cd terraform && terraform plan

apply: ## Поднять инфраструктуру (контейнер nginx на :8081)
	cd terraform && terraform apply

configure: ## Настроить сервер Ansible-ом
	cd ansible && ansible-playbook playbook.yml

verify: ## Проверить результат
	cd ansible && ansible-playbook playbooks/verify.yml

destroy: ## Удалить созданную инфраструктуру
	cd terraform && terraform destroy

fmt: ## Отформатировать .tf файлы
	cd terraform && terraform fmt
