#!/bin/bash

PAYLOAD="$1"

echo "Release URL: https://api.github.com/repos/$REPO/releases" >&2
echo "Release payload: $PAYLOAD" >&2
      
resp=$(curl -s -L \
      --trace-ascii /dev/stderr \
      -X POST \
      -H "Accept: application/vnd.github+json" \
      -H "Authorization: Bearer $TOKEN" \
      -H "X-GitHub-Api-Version: 2022-11-28" \
      https://api.github.com/repos/$REPO/releases \
      -d "$PAYLOAD")

echo "Resp: $resp" >&2
echo $(echo $resp | jq '.id')