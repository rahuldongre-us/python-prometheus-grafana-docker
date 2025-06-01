#!/bin/bash

set -e

# === Config === 
PROJECT_NAME="prometheus-docker"

mkdir -p reports
EXIT_CODE=0

echo "🔍 Running Checkov on Terraform..."
checkov -d . --quiet --output json > reports/checkov.json || true

echo "🔍 Running Trivy on Dockerfile..."
trivy config app/Dockerfile --severity CRITICAL --format json --output reports/trivy.json || true

# === Parse Checkov ===
CRITICAL_CHECKOV=$(jq '[.results.failed_checks[] | select(.severity=="CRITICAL")] | length' reports/checkov.json)

# === Parse Trivy ===
CRITICAL_TRIVY=$(jq '[.Results[].Misconfigurations[]? | select(.Severity=="CRITICAL")] | length' reports/trivy.json)

TOTAL_CRITICAL=$((CRITICAL_CHECKOV + CRITICAL_TRIVY))

# === Slack Alert ===
if [ "$TOTAL_CRITICAL" -gt 0 ]; then
  EXIT_CODE=1
  echo "❌ Found $TOTAL_CRITICAL CRITICAL issues."
else
  echo "✅ No critical issues found."
fi

exit $EXIT_CODE
