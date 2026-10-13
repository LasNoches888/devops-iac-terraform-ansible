# Рабочий процесс IaC

Лаба разделяет две задачи, как это делают в реальных проектах:

| Инструмент | Отвечает за | В этой лабе |
|------------|-------------|-------------|
| Terraform | **создание** ресурсов (декларативно) | образ `nginx:alpine` и контейнер `iac-lab-web` на порту 8081 |
| Ansible | **конфигурацию** внутри ресурсов (идемпотентно) | развёртывание `index.html` через роль `webserver` |

## Жизненный цикл

```
terraform init → terraform plan → terraform apply → ansible-playbook → verify → terraform destroy
```

1. `make init` — Terraform скачивает провайдер `kreuzwerker/docker`.
2. `make plan` — показывает, какие ресурсы будут созданы. **Всегда читайте план перед `apply`.**
3. `make apply` — создаёт образ и контейнер. Адрес выводится в `web_url`.
4. `make configure` — запускает роль `webserver`. Повторный запуск ничего не меняет (`changed=0`) — это и есть идемпотентность.
5. `make verify` — проверяет, что файл развёрнут, а nginx отвечает кодом 200.
6. `make destroy` — удаляет всё, что создал Terraform.

## Состояние Terraform

Terraform хранит состояние в `terraform.tfstate`. Файл:
- не должен попадать в git (уже в `.gitignore`) — в нём могут оказаться секреты;
- в командной работе хранится в удалённом backend (S3, GCS, Terraform Cloud) с блокировкой.

## Идемпотентность — проверьте сами

```bash
make configure     # первый запуск: changed=1
make configure     # второй запуск: changed=0
rm /tmp/iac-lab-index.html
make configure     # снова changed=1 — Ansible вернул систему к описанному состоянию
```

## Задания

1. Вынесите имя контейнера и внешний порт в переменные Terraform (`variables.tf`) и передайте их через `-var`.
2. Добавьте в роль `webserver` шаблон `index.html.j2` (модуль `template`) с подстановкой имени хоста.
3. Смонтируйте результат работы Ansible в контейнер (`volumes` в `docker_container`) и убедитесь, что страница отдаётся nginx.
