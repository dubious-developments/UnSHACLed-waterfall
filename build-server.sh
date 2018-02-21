#!/usr/bin/env bash

# Pull in the latest sources.
git pull
git submodule update --init --recursive --remote

pushd UnSHACLed-server/UnSHACLed
# Download dependencies.
npm install
# Build the client.
gulp build
popd
