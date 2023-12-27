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

curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GH_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/orgs/$ORGANIZATION/repos \
  -d "{\"name\":\"$REPOSITORY_NAME\",\"description\":\"$REPOSITORY_DESCRIPTION\",\"homepage\":\"https://github.com/$ORGANIZATION/$REPOSITORY_NAME\",\"private\":$PRIVATE,\"has_issues\":$HAS_ISSUES,\"visibility\":\"$VISIBILITY\",\"has_projects\":$HAS_PROJECTS,\"has_wiki\":$HAS_WIKI,\"gitignore_template\":\"$GITIGNORE_TEMPLATE\",\"license_template\":\"$LICENSE_TEMPLATE\"}"
