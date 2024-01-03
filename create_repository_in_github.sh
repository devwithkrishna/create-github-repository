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
AUTO_INIT_README=$8
GITIGNORE_TEMPLATE=$9
LICENSE_TEMPLATE=${10}


# Create the base payload without gitignore_template and license template
payload="{\"name\":\"$REPOSITORY_NAME\",\"description\":\"$REPOSITORY_DESCRIPTION\",\"homepage\":\"https://github.com/$ORGANIZATION/$REPOSITORY_NAME\",\"private\":$PRIVATE,\"has_issues\":$HAS_ISSUES,\"visibility\":\"$VISIBILITY\",\"has_projects\":$HAS_PROJECTS,\"has_wiki\":$HAS_WIKI,\"auto_init\":$AUTO_INIT_README"


# Function to add template field to the payload
addTemplateField() {
  local templateVar=$1
  local templateName=$2
  if [ -n "$templateVar" ] && [ "$templateVar" != " " ]; then
    payload="$payload,\"$templateName\":\"$templateVar\""
  fi
}

# Create the base payload without gitignore_template and license template
payload="{\"name\":\"$REPOSITORY_NAME\",\"description\":\"$REPOSITORY_DESCRIPTION\",\"homepage\":\"https://github.com/$ORGANIZATION/$REPOSITORY_NAME\",\"private\":$PRIVATE,\"has_issues\":$HAS_ISSUES,\"visibility\":\"$VISIBILITY\",\"has_projects\":$HAS_PROJECTS,\"has_wiki\":$HAS_WIKI"

# Add gitignore_template to the payload if it is not empty and not equal to a single space
addTemplateField "$GITIGNORE_TEMPLATE" "gitignore_template"

# Add license_template to the payload if it is not empty and not equal to a single space
addTemplateField "$LICENSE_TEMPLATE" "license_template"

# Complete the payload
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
