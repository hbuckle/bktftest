#!/bin/bash

set -euo pipefail

az login --msi
TOKEN=$(curl http://localhost:50342/oauth2/token --data "resource=https://management.azure.com/" -H Metadata:true -s)
echo "[$TOKEN]" > $HOME/.azure/accessTokens.json
cat $HOME/.azure/accessTokens.json
terraform init -input=false
terraform plan -input=false -out=bkplan.tfplan
buildkite-agent artifact upload bkplan.tfplan