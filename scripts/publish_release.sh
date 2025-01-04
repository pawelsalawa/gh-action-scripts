#!/bin/bash

RELEASE_ID=$1

payload="{\"draft\":false}"
curl -s -L \
  -X PATCH \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/$REPO/releases/$RELEASE_ID \
  -d $payload
