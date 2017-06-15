#!/bin/sh

set -e

cd "${PWD}"/../ || true
echo "${PWD}"
exit

VERSION=$1
if [ -z "$1" ]
then
  echo "Please provide unique hotfix name. Jira ticket number is a good candidate"
  exit 1
fi

# ensure you are on latest develop  & master
git checkout develop
git pull origin develop
git checkout -

git checkout master
git pull origin master
git checkout develop

#Initialize gitflow
git flow init -f -d

git flow hotfix start "$VERSION"

NEXTVERSION=$(./bump-patchversion.sh)
./bump-version.sh "$NEXTVERSION"
git commit -am "Bumps version to $NEXTVERSION"

# bump hotfix version to server
git push
