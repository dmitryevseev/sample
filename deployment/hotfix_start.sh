#!/bin/sh

set -e

cd "${PWD}"/../ || true

VERSION=$1
if [ -z "$1" ]
then
  echo "Please provide unique hotfix name. Jira ticket number is a good candidate"
  exit 1
fi

# Initialize gitflow
git flow init -f -d
git flow hotfix start -F origin "$VERSION"

NEXTVERSION=$(./bump-patchversion.sh)
./bump-version.sh "$NEXTVERSION"
git commit -am "Bumps version to $NEXTVERSION"

# bump hotfix version to server
git push
