#!/bin/bash

set -euo pipefail

login=$(az login --msi)
export ARM_TENANT_ID=$(echo $login | jq -r '.[].tenantId')
export ARM_SUBSCRIPTION_ID=$(echo $login | jq -r '.[].id')

buildkite-agent artifact download terraform-plan.zip .
unzip terraform-plan.zip

COMMAND=$(buildkite-agent meta-data get terraform-command)
case $COMMAND in
  "apply")
    terraform apply -input=false bkplan.tfplan
    ;;
  "destroy")
    terraform destroy --force
    ;;
  "refresh")
    terraform refresh -input=false
    ;;
esac