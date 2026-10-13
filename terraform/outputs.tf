output "container_name" {
  description = "Имя созданного контейнера"
  value       = docker_container.web.name
}

output "web_url" {
  description = "Адрес веб-сервера на хосте"
  value       = "http://localhost:${tolist(docker_container.web.ports)[0].external}"
}
