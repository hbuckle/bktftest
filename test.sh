#!/bin/bash

set -eu

./get-tf-input.sh | buildkite-agent pipeline upload