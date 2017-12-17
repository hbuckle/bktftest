#!/bin/bash

set -euo pipefail

TOKEN=$(curl http://localhost:50342/oauth2/token --data "resource=https://management.azure.com/" -H Metadata:true -s)
echo "[$TOKEN]" > $HOME/.azure/accessTokens.json
terraform plan -input=false -out=bkplan.tfplan
buildkite-agent artifact upload bkplan.tfplan