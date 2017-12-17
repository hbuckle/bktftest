#!/bin/bash

set -euo pipefail

az login --msi
ID=$(az account show | jq -r '.id')
az account set -s $ID
az account get-access-token | jq -c '[ .]' > $HOME/.azure/accessTokens.json
terraform init -input=false
terraform plan -input=false -out=bkplan.tfplan
buildkite-agent artifact upload bkplan.tfplan