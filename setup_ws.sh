#!/usr/bin/env bash

SCRIPT_PATH=$(dirname $(realpath ${BASH_SOURCE:-$0}))
set -o errexit -o pipefail -o noclobber -o nounset
