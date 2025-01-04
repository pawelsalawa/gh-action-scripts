#!/bin/bash

TAG_NAME="$1"
RELEASE_NAME="$2"
RELEASE_DESCRIPTION="$3"

payload="{\"tag_name\":\"$TAG_NAME\",\"name\":\"$RELEASE_NAME\",\"body\":\"$RELEASE_DESCRIPTION\",\"draft\":true}"
resp=$(curl -s -L \
      -X POST \
      -H "Accept: application/vnd.github+json" \
      -H "Authorization: Bearer $TOKEN" \
      -H "X-GitHub-Api-Version: 2022-11-28" \
      https://api.github.com/repos/$REPO/releases \
      -d "$payload")

echo $(echo $resp | jq '.id')