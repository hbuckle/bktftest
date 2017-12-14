#!/bin/bash

set -eu

chmod 755 ./get-tf-input.sh
ls -l ./get-tf-input.sh
./get-tf-input.sh | buildkite-agent pipeline upload