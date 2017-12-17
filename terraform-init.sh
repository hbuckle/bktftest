#!/bin/bash

set -euo pipefail

apk add terraform --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community
login=$(az login --msi)
export TENANT_ID=$(echo $login | jq -r '.[].tenantId')
response=$(curl http://localhost:50342/oauth2/token --data "resource=https://management.azure.com/" -H Metadata:true -s)
echo $response | python access-token.py | jq -c '[.]' > $HOME/.azure/accessTokens.json
cat $HOME/.azure/accessTokens.json