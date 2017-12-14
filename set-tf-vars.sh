#!/bin/bash

set -eu

for i in $(cat ./variables.tf.json | jq '.["variable"] | keys[]'); do
  temp="${i%\"}"
  temp="${temp#\"}"
  echo "$temp = $(buildkite-agent meta-data get $temp)" >> bk.tfvars
done