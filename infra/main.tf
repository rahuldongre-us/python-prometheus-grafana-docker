terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {} 

# Network
resource "docker_network" "monitor_net" {
  name = "monitor-net"
}

locals {
  python_app_name = "${var.name_prefix}-${random_string.name.id}-${var.environment}"
} 

# Python Application
resource "docker_image" "python_app" {
  name         = local.python_app_name
  build { 
    context    = abspath("${path.module}/../app")
    #dockerfile = abspath("${path.module}/../app/Dockerfile")
  }
}

resource "docker_container" "python_app" {
  name  = local.python_app_name
  image = docker_image.python_app.name
  ports {
    internal = 8000
    external = 8000
  }
  
  healthcheck {
    test     = ["CMD-SHELL", "curl -f http://localhost:8000/ || exit 1"]
    interval = "30s"
    timeout  = "10s"
    retries  = 3
  }

  restart = "on-failure"

  max_retry_count = 5
   
  networks_advanced {
    name = docker_network.monitor_net.name
  }
}

# Prometheus

resource "docker_image" "prometheus" {
  name = "prom/prometheus:latest"
}

resource "docker_container" "prometheus" {
  name  = "prometheus"
  image = docker_image.prometheus.name
  ports {
    internal = 9090
    external = 9090
  }

  volumes {
    host_path      = abspath("${path.module}/../prometheus/prometheus.yml")
    container_path = "/etc/prometheus/prometheus.yml"
  }

  command = ["--config.file=/etc/prometheus/prometheus.yml"]

  healthcheck {
    test     = ["CMD-SHELL", "wget --spider -q http://localhost:9090/-/ready || exit 1"]
    interval = "30s"
    timeout  = "10s"
    retries  = 3
  }

  restart = "unless-stopped"

  networks_advanced {
    name = docker_network.monitor_net.name
  }
}

# Grafana
resource "docker_image" "grafana" {
  name = "grafana/grafana:latest"
}

resource "docker_container" "grafana" {
  name  = "grafana"
  image = docker_image.grafana.name
  ports {
    internal = 3000
    external = 3000
  }
    volumes {
    host_path      = abspath("${path.module}/../grafana/provisioning")
    container_path = "/etc/grafana/provisioning"
  }
  volumes {
    host_path      = abspath("${path.module}/../grafana/dashboards")
    container_path = "/etc/grafana/provisioning/dashboards"
  }
  env = [
    "GF_SECURITY_ADMIN_PASSWORD=admin"
  ]
    healthcheck {
    test     = ["CMD-SHELL", "curl -f http://localhost:3000/login || exit 1"]
    interval = "30s"
    timeout  = "10s"
    retries  = 3
  }

  restart = "unless-stopped"

  networks_advanced {
    name = docker_network.monitor_net.name
  }
}