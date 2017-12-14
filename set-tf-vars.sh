#!/bin/bash

set -eu

for i in $(cat ./variables.tf.json | jq '.["variable"] | keys[]'); do
  export TF_$i=$(buildkite-agent meta-data get $i)
done