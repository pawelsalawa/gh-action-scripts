#!/bin/bash

WORKFLOW=$1
PAYLOAD=$2

child_dt=$(date -d 'now - 5 seconds' +%Y-%m-%dT%H:%M:%S)

curl -s -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/$REPO/actions/workflows/$WORKFLOW/dispatches \
  -d $PAYLOAD

sleep 1
url=https://api.github.com/repos/$REPO/actions/workflows/$WORKFLOW/runs?created=\>$child_dt

run_id="null"
it=0
while [ "$run_id" == "null" ] && [ $it -lt 10 ]
do
    resp=$(
            curl -s -L \
              -H "Accept: application/vnd.github+json" \
              -H "Authorization: Bearer $TOKEN" \
              -H "X-GitHub-Api-Version: 2022-11-28" \
              $url
          )
    run_id=$(echo $resp | jq '.workflow_runs[0].id')
    it=$((it + 1))
    sleep 1
done

echo "Run ID for workflow $WORKFLOW: $run_id" >&2
if [ "$run_id" == "null" ]
then
    echo "Null Run ID for $WORKFLOW." >&2
    exit 1
fi
echo $run_id

