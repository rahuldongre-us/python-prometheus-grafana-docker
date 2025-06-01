#!/bin/bash

# Exit on error
set -e

cd ./infra 

terraform init
terraform validate
terraform apply -auto-approve