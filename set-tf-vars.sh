#!/bin/bash

set -eu

for i in $(cat ./variables.tf.json | jq '.["variable"] | keys[]'); do
  temp="${i%\"}"
  temp="${temp#\"}"
  export TF_$temp=$(buildkite-agent meta-data get $temp)
done