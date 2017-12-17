#!/bin/bash

set -euo pipefail

apk add terraform --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community
TOKEN=$(curl http://localhost:50342/oauth2/token --data "resource=https://management.azure.com/" -H Metadata:true -s)
mkdir -p $HOME/.azure
echo "[$TOKEN]" > $HOME/.azure/accessTokens.json
cat $HOME/.azure/accessTokens.json
terraform init -input=false