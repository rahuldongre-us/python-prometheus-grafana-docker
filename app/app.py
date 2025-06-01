from flask import Flask
from prometheus_client import Counter, generate_latest, CONTENT_TYPE_LATEST
from prometheus_client import start_http_server

app = Flask(__name__)

# Define a metric
REQUEST_COUNT = Counter("app_requests_total", "Total HTTP Requests")

@app.route("/")
def index():
    REQUEST_COUNT.inc()
    return "Hello from Python App for Grafana Prometheus!"

@app.route("/metrics")
def metrics():
    return generate_latest(), 200, {'Content-Type': CONTENT_TYPE_LATEST}

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
