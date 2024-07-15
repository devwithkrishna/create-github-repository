#!/bin/bash

# GH_TOKEN --> will be passed from the workflow as an env variable
ORGANIZATION=$1
REPOSITORY_NAME=$2
REPOSITORY_DESCRIPTION=$3
PRIVATE=$4
VISIBILITY=$5
HAS_ISSUES=$6
HAS_PROJECTS=$7
HAS_WIKI=$8
GITIGNORE_TEMPLATE=$9
LICENSE_TEMPLATE=${10}

# Construct the JSON payload
JSON_PAYLOAD="{\"name\":\"$REPOSITORY_NAME\",\"description\":\"$REPOSITORY_DESCRIPTION\",\"homepage\":\"https://github.com/$ORGANIZATION/$REPOSITORY_NAME\",\"auto_init\":true,\"private\":$PRIVATE,\"has_issues\":$HAS_ISSUES,\"visibility\":\"$VISIBILITY\",\"has_projects\":$HAS_PROJECTS,\"has_wiki\":$HAS_WIKI"

# Add gitignore_template if it is not "None"
if [ "$GITIGNORE_TEMPLATE" != "None" ]; then
  JSON_PAYLOAD="$JSON_PAYLOAD,\"gitignore_template\":\"$GITIGNORE_TEMPLATE\""
fi

# Add license_template if it is not "None"
if [ "$LICENSE_TEMPLATE" != "None" ]; then
  JSON_PAYLOAD="$JSON_PAYLOAD,\"license_template\":\"$LICENSE_TEMPLATE\""
fi

# Close the JSON payload
JSON_PAYLOAD="$JSON_PAYLOAD}"

# Execute the curl command
response=$(curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GH_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/orgs/$ORGANIZATION/repos \
  -d "$JSON_PAYLOAD" -w "%{http_code}")

# Extract the HTTP status code from the response
http_code=$(echo "$response" | tail -n1)

if [ "$http_code" -eq 201 ]; then
  echo "Repository - $2 created "
else
  echo "Failed with status code: $http_code"
fi