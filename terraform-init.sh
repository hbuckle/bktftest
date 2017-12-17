#!/bin/bash

set -euo pipefail

apk add terraform --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community
az login --msi
ID=$(az account show --query id)
az account set -s $ID
terraform init -input=false