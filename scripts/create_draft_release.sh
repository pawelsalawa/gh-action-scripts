#!/bin/bash

TAG_NAME="$1"
BRANCH="$2"
RELEASE_NAME="$3"
RELEASE_DESCRIPTION="$4"

SCRIPT_DIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
. $SCRIPT_DIR/common.sh

payload=$(
    jq -n -c \
        --arg tagName "$TAG_NAME" \
        --arg releaseName "$RELEASE_NAME" \
        --arg body "$RELEASE_DESCRIPTION" \
        --arg branch "$BRANCH" \
        '{
            "tag_name": $tagName,
            "target_commitish": $branch,
            "name": $releaseName,
            "body": $body,
            "draft":true
        }'
    )

debug "Creting release - payload:\n$payload"
resp=$(curl -s -L \
      -X POST \
      -H "Accept: application/vnd.github+json" \
      -H "Authorization: Bearer $TOKEN" \
      -H "X-GitHub-Api-Version: 2022-11-28" \
      https://api.github.com/repos/$REPO/releases \
      -d "$payload")

debug "Response:n$resp"

echo $(echo $resp | jq '.id')