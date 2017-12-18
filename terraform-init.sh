#!/bin/bash

set -euo pipefail

apk add terraform --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community
login=$(az login --msi)
export ARM_TENANT_ID=$(echo $login | jq -r '.[].tenantId')
export ARM_MSI_ENDPOINT=http://localhost:50342/oauth2/token
export ARM_USE_MSI=true
export ARM_SUBSCRIPTION_ID=$(echo $login | jq -r '.[].id')
mkdir -p ./terraform.d/plugins/linux_amd64
curl -Lfs -o ./terraform.d/plugins/linux_amd64/terraform-provider-azurerm_v1.0.0_x4 https://cdn-05.anonfile.com/c6F8nfd8ba/c197cb53-1513551501/terraform-provider-azurerm