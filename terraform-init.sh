#!/bin/bash

set -euo pipefail

apk add zip --no-cache
apk add unzip --no-cache
apk add terraform --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community
login=$(az login --msi)
export ARM_TENANT_ID=$(echo $login | jq -r '.[].tenantId')
export ARM_SUBSCRIPTION_ID=$(echo $login | jq -r '.[].id')
mkdir -p ./terraform.d/plugins/linux_amd64
curl -Lfs -o "./terraform.d/plugins/linux_amd64/terraform-provider-azurerm_v1.0.0_x4" https://temptf.blob.core.windows.net/temp/terraform-provider-azurerm_v1.0.0_x4
chmod +x ./terraform.d/plugins/linux_amd64/terraform-provider-azurerm_v1.0.0_x4
state_storage_access_key=$(
  az storage account keys list \
    --resource-group "subscription-terraform-state-northeurope" \
    --account-name "qifoghtnvyauqtr" \
    --query '[0].value' -o tsv
)
terraform init -input=false -backend-config="access_key=$state_storage_access_key"
zip -r terraform-init.zip ./.terraform ./terraform.d
buildkite-agent artifact upload terraform-init.zip
ls -la ./