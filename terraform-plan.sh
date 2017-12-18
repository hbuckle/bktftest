#!/bin/bash

set -euo pipefail

login=$(az login --msi)
export ARM_TENANT_ID=$(echo $login | jq -r '.[].tenantId')
export ARM_SUBSCRIPTION_ID=$(echo $login | jq -r '.[].id')
mkdir -p ./terraform.d/plugins/linux_amd64
curl -Lfs -o "./terraform.d/plugins/linux_amd64/terraform-provider-azurerm_v1.0.0_x4" https://temptf.blob.core.windows.net/temp/terraform-provider-azurerm_v1.0.0_x4
terraform init -input=false

terraform plan -input=false -out=bkplan.tfplan
buildkite-agent artifact upload bkplan.tfplan