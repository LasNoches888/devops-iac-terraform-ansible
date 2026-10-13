# devops-iac-terraform-ansible

Инфраструктура как код: Terraform поднимает контейнеры (docker provider — без облачных кредов),
Ansible настраивает внутри них веб-сервер.

## Запуск
```bash
cd terraform && terraform init && terraform apply
cd ../ansible && ansible-playbook -i inventory.ini playbook.yml
```

## Дополнительно
- `Makefile` — `make init|plan|apply|configure|verify|destroy`.
- `ansible/playbooks/verify.yml` — проверка результата (файл развёрнут, nginx отвечает кодом 200).
- `terraform/outputs.tf` — имя контейнера и адрес веб-сервера после `apply`.
- `docs/workflow.md` — жизненный цикл IaC, состояние Terraform, идемпотентность, задания.
