#!/bin/bash

set -euo pipefail

az account get-access-token | jq -c '[ .]' > $HOME/.azure/accessTokens.json
terraform init -input=false
terraform plan -input=false -out=bkplan.tfplan
buildkite-agent artifact upload bkplan.tfplan