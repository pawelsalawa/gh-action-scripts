#!/bin/bash

RELEASE_ID=$1
BODY=$2

SCRIPT_DIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
. $SCRIPT_DIR/common.sh

payload=$(
    js -n -c \
        --arg body "$BODY" \
        '{"body": $body}'
    )
debug "Update release - payload:\n$payload"
resp=$(curl -s -L \
  -X PATCH \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/$REPO/releases/$RELEASE_ID \
  -d $payload)
debug "Response:\n$resp"