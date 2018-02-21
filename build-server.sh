#!/usr/bin/env bash

pushd UnSHACLed-server/UnSHACLed
# Download dependencies.
npm install
# Build the client.
gulp build
popd
