#!/bin/bash

set -euo pipefail

apk add terraform --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community
ID=$(az login --msi | jq -r '.[].id')
az account set -s $ID
az account get-access-token | jq -c '[.]' > $HOME/.azure/accessTokens.json