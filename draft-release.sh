#!/usr/bin/env bash
set -e

# Drafts a new release. Release branch is specified as first argument.

# Figure out what the current branch is so we can go back
# to our cosy little corner of the Universe when we're done here.
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Create a new release branch.
RELEASE_BRANCH=$1
git checkout -B $RELEASE_BRANCH

# Update all submodules.
git submodule update --recursive --init

# Pull in latest versions of submodules. Update recursively.
pushd UnSHACLed-server
pushd UnSHACLed
git pull origin master
popd
git add .
git commit -m "Update UnSHACLed client to latest version"; git push origin master
popd

pushd UnSHACLed-collaboration-server
git pull origin master
popd

git add .
git commit -m "Update UnSHACLed server to latest version"
git push -f --set-upstream origin $RELEASE_BRANCH

# Switch back to current branch.
git checkout $CURRENT_BRANCH
