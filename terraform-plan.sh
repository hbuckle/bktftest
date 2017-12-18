#!/bin/bash

set -euo pipefail

terraform init -input=false
terraform plan -input=false -out=bkplan.tfplan
buildkite-agent artifact upload bkplan.tfplan