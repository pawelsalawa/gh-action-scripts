#!/bin/bash

PAYLOAD=$1

resp=$(curl -s -L \
      -X POST \
      -H "Accept: application/vnd.github+json" \
      -H "Authorization: Bearer $TOKEN" \
      -H "X-GitHub-Api-Version: 2022-11-28" \
      https://api.github.com/repos/$REPO/releases \
      -d $PAYLOAD)
#resp=$(cat ../release_resp.json)
echo $(echo $resp | jq '.id')
