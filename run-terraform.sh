#!/bin/bash

set -euo pipefail

COMMAND=$(buildkite-agent meta-data get terraform-command)
az login --msi
terraform init -input=false
case $COMMAND in
  "apply")
    buildkite-agent artifact download bkplan.tfplan
    terraform apply -input=false bkplan.tfplan
    ;;
  "destroy")
    terraform destroy --force
    ;;
  "refresh")
    terraform refresh -input=false
    ;;
esac