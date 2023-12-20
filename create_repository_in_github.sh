#! /bin/bash

#GH_TOKEN --> will be passed from workflow as env variable

curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GH_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/orgs/$ORGANIZATION/repos \
  -d '{"name":$REPOSITORY_NAME,"description":$c,"homepage":"https://github.com/"$ORGANIZATION/$REPOSITORY_NAME","private":$VISIBILITY,"has_issues":$HAS_ISSUES,"visibility":$VISIBILITY,"has_projects":$HAS_PROJECTS,"has_wiki":$HAS_WIKI,"gitignore_template":$GITIGNORE_TEMPLATE,"license_template":$LICENSE_TEMPLATE}'