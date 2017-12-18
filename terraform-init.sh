#!/bin/bash

set -euo pipefail

mkdir -p $TF_PLUGIN_CACHE_DIR
apk add terraform --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community
login=$(az login --msi)
export ARM_TENANT_ID=$(echo $login | jq -r '.[].tenantId')
export ARM_SUBSCRIPTION_ID=$(echo $login | jq -r '.[].id')
curl -Lfs -o "$TF_PLUGIN_CACHE_DIR/terraform-provider-azurerm_v1.0.0_x4" https://temptf.blob.core.windows.net/temp/terraform-provider-azurerm_v1.0.0_x4
terraform init -input=false