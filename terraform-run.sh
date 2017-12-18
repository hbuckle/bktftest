#!/bin/bash

set -euo pipefail

login=$(az login --msi)
export ARM_TENANT_ID=$(echo $login | jq -r '.[].tenantId')
export ARM_SUBSCRIPTION_ID=$(echo $login | jq -r '.[].id')
mkdir -p ./terraform.d/plugins/linux_amd64
curl -Lfs -o "./terraform.d/plugins/linux_amd64/terraform-provider-azurerm_v1.0.0_x4" https://temptf.blob.core.windows.net/temp/terraform-provider-azurerm_v1.0.0_x4
chmod +x ./terraform.d/plugins/linux_amd64/terraform-provider-azurerm_v1.0.0_x4
terraform init -input=false

COMMAND=$(buildkite-agent meta-data get terraform-command)
case $COMMAND in
  "apply")
    buildkite-agent artifact download bkplan.tfplan .
    terraform apply -input=false bkplan.tfplan
    ;;
  "destroy")
    terraform destroy --force
    ;;
  "refresh")
    terraform refresh -input=false
    ;;
esac