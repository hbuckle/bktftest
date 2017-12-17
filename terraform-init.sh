#!/bin/bash

set -euo pipefail

apk add terraform --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community
az login --msi
terraform init -input=false