output "grafana_url" {
  value = "http://localhost:3000"
}
output "alertmanager_url" {
  value = "http://localhost:9093"
}
output "prometheus_url" {
  value = "http://localhost:9090"
}
output "python_app_name" {
  value = docker_container.python_app.name
}
output "python_app_port" {
  value = var.python_port
}
output "python_app_url" {
  value = "http://localhost:8000"
}
