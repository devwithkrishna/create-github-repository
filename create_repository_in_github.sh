#!/bin/bash
# maximum of 10 inputs can be set for a workflow_despatch event. so hardcoding the organization here

# GH_TOKEN --> will be passed from the workflow as an env variable
ORGANIZATION="devwithkrishna"
REPOSITORY_NAME=$1
REPOSITORY_DESCRIPTION=$2
PRIVATE=$3
VISIBILITY=$4
HAS_ISSUES=$5
HAS_PROJECTS=$6
HAS_WIKI=$7
GITIGNORE_TEMPLATE=$8
LICENSE_TEMPLATE=$9
AUTO_INIT_README=${10}

# Create the base payload without gitignore_template and license template
payload="{\"name\":\"$REPOSITORY_NAME\",\"description\":\"$REPOSITORY_DESCRIPTION\",\"homepage\":\"https://github.com/$ORGANIZATION/$REPOSITORY_NAME\",\"private\":$PRIVATE,\"has_issues\":$HAS_ISSUES,\"visibility\":\"$VISIBILITY\",\"has_projects\":$HAS_PROJECTS,\"has_wiki\":$HAS_WIKI"

# Check if gitignore template is provided, and if so, append it to the payload
if [ -n "$GITIGNORE_TEMPLATE" ] && [ "$GITIGNORE_TEMPLATE" != " " ]; then
  payload="$payload,\"gitignore_template\":\"$GITIGNORE_TEMPLATE\""
fi

# Check if license template is provided, and if so, append it to the payload
if [ -n "$LICENSE_TEMPLATE" ] && [ "$LICENSE_TEMPLATE" != " " ]; then
  payload="$payload,\"license_template\":\"$LICENSE_TEMPLATE\""
fi

# Close the payload
payload="$payload}"

# Send the request to create the repository
curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GH_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/orgs/$ORGANIZATION/repos \
  -d "$payload"

# curl -L \
#   -X POST \
#   -H "Accept: application/vnd.github+json" \
#   -H "Authorization: Bearer $GH_TOKEN" \
#   -H "X-GitHub-Api-Version: 2022-11-28" \
#   https://api.github.com/orgs/$ORGANIZATION/repos \
#   -d "{\"name\":\"$REPOSITORY_NAME\",\"description\":\"$REPOSITORY_DESCRIPTION\",\"homepage\":\"https://github.com/$ORGANIZATION/$REPOSITORY_NAME\",\"private\":$PRIVATE,\"has_issues\":$HAS_ISSUES,\"visibility\":\"$VISIBILITY\",\"has_projects\":$HAS_PROJECTS,\"has_wiki\":$HAS_WIKI,\"gitignore_template\":\"$GITIGNORE_TEMPLATE\",\"license_template\":\"$LICENSE_TEMPLATE\"}"
