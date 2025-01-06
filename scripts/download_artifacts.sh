#!/bin/bash

RUN_ID=$1
FILTER="$2"

resp=$(curl -s -L \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/$REPO/actions/runs/$RUN_ID/artifacts)

if [ "$FILTER" != "" ]
then
    FILTER=".artifacts[] | select($FILTER) | .archive_download_url"
else
    FILTER=".artifacts[].archive_download_url"
fi

for URL in $(echo $resp | jq -r "$FILTER")
do
    echo "Download URL for $RUN_ID: $URL" >&2
    curl -O -J -s -L -H "Authorization: Bearer $TOKEN" $URL
done
