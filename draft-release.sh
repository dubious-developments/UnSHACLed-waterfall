#!/usr/bin/env bash
set -e

# Drafts a new release. Release branch is specified as first argument.
RELEASE_BRANCH=$1
git checkout -b $RELEASE_BRANCH
git submodule update --recursive --init

pushd UnSHACLed-server
pushd UnSHACLed
git pull origin master
popd
git add .
git commit -m "Update UnSHACLed client to latest version"
git push origin master
popd

pushd UnSHACLed-collaboration-server
git pull origin master
popd

git commit -m "Update UnSHACLed server to latest version"
git push --set-upstream origin $RELEASE_BRANCH
