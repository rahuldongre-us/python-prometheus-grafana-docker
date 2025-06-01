# 🚀 Python + Prometheus + Grafana Monitoring Stack (Dockerized)

Monitor your Python applications in real-time with a production-ready monitoring stack using **Prometheus**, **Grafana** and **Docker**. This repository helps developers and DevOps engineers bootstrap observability for microservices or monoliths with minimal setup. Checkov uses a common command line interface to manage and analyze infrastructure as code (IaC) scan results across platforms such as Terraform and other framework. Trivy to find vulnerabilities (CVE) & misconfigurations (IaC) across code repositories, binary artifacts, container images and more. All in one tool!

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![Docker Compose](https://img.shields.io/badge/Docker--Compose-Ready-blue)
[![Stars](https://img.shields.io/github/stars/rahuldongre-us/python-prometheus-grafana-docker?style=social)](https://github.com/rahuldongre-us/python-prometheus-grafana-docker/stargazers)
[![Issues](https://img.shields.io/github/issues/rahuldongre-us/python-prometheus-grafana-docker)](https://github.com/rahuldongre-us/python-prometheus-grafana-docker/issues)
[![Last Commit](https://img.shields.io/github/last-commit/rahuldongre-us/python-prometheus-grafana-docker)](https://github.com/rahuldongre-us/python-prometheus-grafana-docker/commits/main)


---

## 📊 Features

✅ Easy setup with Docker Compose  
✅ Python app exposing metrics with `prometheus_client`  
✅ Pre-configured Prometheus scrape targets  
✅ Grafana ready for dashboards  
✅ Modular and extensible for production use  

---

## ⚙️ Quick Start

### Prerequisites

- Docker & Docker Compose installed
- Python 3.7+ (optional, for local testing)

### Clone the Repository

```bash
git clone https://github.com/rahuldongre-us/python-prometheus-grafana-docker.git
cd python-prometheus-grafana-docker
docker-compose up --build -d
```

or 

Start the application.

``` bash
  chmod +x infra.sh 
  ./infra.sh
```
Local docker should expose python app, prometheus and grafana.

Destroy the application.

``` bash
  chmod +x cleanup-infra.sh
  ./cleanup-infra.sh
```

Scan for misconfiguration, CVE and other vulnerabilities. 

``` bash
  chmod +x scan.sh
  ./scan.sh
```
Splunk and email notification can be setup based on scan results at build time.


| Service    | URL                                                            | Notes                            |
| ---------- | -------------------------------------------------------------- | -------------------------------- |
| Grafana    | [http://localhost:3000](http://localhost:3000)                 | Default login: `admin` / `admin` |
| Prometheus | [http://localhost:9090](http://localhost:9090)                 | Live metrics & targets           |
| Python App | [http://localhost:8000/metrics](http://localhost:8000/metrics) | Prometheus metrics endpoint      |

---

🛠️ Customize & Extend

Add More Metrics

Edit app/main.py and add custom Prometheus metrics using prometheus_client:

from prometheus_client import Counter

REQUESTS = Counter('http_requests_total', 'Total HTTP Requests')

Add More Services
Just define new services in docker-compose.yml and update prometheus.yml to scrape their metrics.

---
## Checkov

pip install checkov

docker run --rm -v $(pwd):/tf bridgecrew/checkov --directory /tf

### For Terraform files
checkov -d .

### For Dockerfiles
checkov --dockerfile-path ./app/Dockerfile

### Terraform & Dockerfile

docker run --rm -v $(pwd):/tf bridgecrew/checkov --directory /tf

docker run --rm -v $(pwd)/app/Dockerfile:/Dockerfile bridgecrew/checkov --dockerfile-path /Dockerfile

---
## Trivy

brew install aquasecurity/trivy/trivy      

docker run --rm -v $(pwd):/project aquasec/trivy config /project

trivy config .

### Example: scan Python app image built by Terraform

trivy image python_app

---

📌 Use Cases

📊 Monitoring microservices

⚙️ System observability in Dev/Test environments

🚨 Alerting integration with Prometheus AlertManager

🧪 Teaching/promoting observability best practices

---

🧠 Resources

[Prometheus Docs ](https://prometheus.io/docs/) 

[Grafana Docs](https://grafana.com/docs/)

[Prometheus Python Client](https://github.com/prometheus/client_python)

[Checkov](https://www.checkov.io/)

[Trivy](https://trivy.dev/latest/)

---

🙌 Acknowledgments

Built with ❤️ by Rahul Dongre
Inspired by open-source observability stacks worldwide.
