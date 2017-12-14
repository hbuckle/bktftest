#!/bin/bash

set -eu

echo 'steps:'
echo '  - block: "Notify"'
echo '    fields:'

for i in $(cat ./variables.tf.json | jq '.["variable"] | keys[]'); do
  echo "      - text: $i"
  echo "        key: $i"
  echo '        required: true'
done