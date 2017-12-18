#!/bin/bash

set -euo pipefail

login=$(az login --msi)
export ARM_TENANT_ID=$(echo $login | jq -r '.[].tenantId')
export ARM_SUBSCRIPTION_ID=$(echo $login | jq -r '.[].id')

buildkite-agent artifact download terraform-init.zip .
unzip terraform-init.zip

COMMAND=$(buildkite-agent meta-data get terraform-command)
case $COMMAND in
  "apply")
    terraform plan -input=false -out=bkplan.tfplan
    ;;
  "destroy")
    terraform plan -destroy -input=false -out=bkplan.tfplan
    ;;
  "refresh")
    terraform plan -input=false -out=bkplan.tfplan
    ;;
esac

zip -r terraform-plan.zip ./.terraform ./terraform.d bkplan.tfplan
buildkite-agent artifact upload terraform-plan.zip