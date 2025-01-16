#!/bin/bash

RELEASE_ID=$1
TAG_NAME=$2
BODY=$3

# TAG_NAME is necessary during release update, probably due to GitHub bug that resets this property of release
# to default (untagged) while patching with this property skipped.

SCRIPT_DIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
. $SCRIPT_DIR/common.sh

payload=$(
    jq -n -c \
        --arg body "$BODY" \
        --arg tagName "$TAG_NAME" \
        '{
            "body": $body,
            "tag_name": $tagName
        }'
    )
debug "Update release - payload:\n$payload"
resp=$(curl -s -L \
  -X PATCH \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/$REPO/releases/$RELEASE_ID \
  -d "$payload")
debug "Response:\n$resp"
