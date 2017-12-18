#!/bin/bash

set -euo pipefail

terraform plan -input=false -out=bkplan.tfplan
buildkite-agent artifact upload bkplan.tfplan