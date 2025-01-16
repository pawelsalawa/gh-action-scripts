#!/bin/bash

RELEASE_ID=$1
FILE=$2

SCRIPT_DIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
. $SCRIPT_DIR/common.sh

fname=$(basename "$FILE")

debug "Uploading file: $FILE"
resp=$(curl -s -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  -H "Content-Type: application/octet-stream" \
  "https://uploads.github.com/repos/$REPO/releases/$RELEASE_ID/assets?name=$fname" \
  --data-binary "@$FILE")
debug "Response:\n$resp"
echo $resp | jq -r '.browser_download_url'
