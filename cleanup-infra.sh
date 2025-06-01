#!/bin/bash

# Exit on error
set -e

cd ./infra  

terraform destroy -auto-approve