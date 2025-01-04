#!/bin/bash

RUN_ID=$1

URL=$(curl -s -L \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/$REPO/actions/runs/$RUN_ID/artifacts \
  | jq -r '.artifacts[0].archive_download_url')
    
echo "Download URL for $RUN_ID: $URL" >&2
curl -O -J -s -L -H "Authorization: Bearer $TOKEN" $URL
