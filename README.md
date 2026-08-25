# devops-iac-terraform-ansible

Инфраструктура как код: Terraform поднимает контейнеры (docker provider — без облачных кредов),
Ansible настраивает внутри них веб-сервер.

## Запуск
```bash
cd terraform && terraform init && terraform apply
cd ../ansible && ansible-playbook -i inventory.ini playbook.yml
```
