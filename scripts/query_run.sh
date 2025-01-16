#!/bin/bash

RUN_ID=$1

SCRIPT_DIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
. $SCRIPT_DIR/common.sh

echo $(curl -s -L \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/$REPO/actions/runs/$RUN_ID)
