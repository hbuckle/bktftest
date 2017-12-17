#!/bin/bash

set -euo pipefail

COMMAND=$(buildkite-agent meta-data get terraform-command)
TOKEN=$(curl http://localhost:50342/oauth2/token --data "resource=https://management.azure.com/" -H Metadata:true -s)
echo "[$TOKEN]" > $HOME/.azure/accessTokens.json
case $COMMAND in
  "apply")
    buildkite-agent artifact download bkplan.tfplan
    terraform apply -input=false bkplan.tfplan
    ;;
  "destroy")
    terraform destroy --force
    ;;
  "refresh")
    terraform refresh -input=false
    ;;
esac