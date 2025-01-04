#!/bin/bash

PAYLOAD=$(cat $1)

temp_file=$(mktemp "${RUNNER_TEMP}/tempfile.XXXXXX")

echo "Release URL: https://api.github.com/repos/$REPO/releases" >&2
echo "Release payload: $PAYLOAD" >&2
      
curl -s -L \
      --trace-ascii /dev/stderr \
      -X POST \
      -H "Accept: application/vnd.github+json" \
      -H "Authorization: Bearer $TOKEN" \
      -H "X-GitHub-Api-Version: 2022-11-28" \
      https://api.github.com/repos/$REPO/releases \
      -d "$PAYLOAD" > $temp_file

echo "Resp: $(cat $temp_file)" >&2
resp=$(cat $temp_file)
echo $(echo $resp | jq '.id')