#!/bin/bash

set -euo pipefail

TOKEN=$(curl http://localhost:50342/oauth2/token --data "resource=https://management.azure.com/" -H Metadata:true -s)
echo $TOKEN | jq -c '[. | .["accessToken"] = .access_token | .["expiresOn"] = .expires_on | .["tokenType"] = .token_type | del(.access_token,.expires_on,.token_type) ]' > $HOME/.azure/accessTokens.json
cat $HOME/.azure/accessTokens.json
terraform init -input=false
terraform plan -input=false -out=bkplan.tfplan
buildkite-agent artifact upload bkplan.tfplan