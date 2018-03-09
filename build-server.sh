#!/usr/bin/env bash

set -e

current_dir_path=$(dirname $0)

pushd "$current_dir_path/UnSHACLed-server/UnSHACLed"
# Download dependencies.
npm install

# Build the client.
gulp build

# Run the tests using a virtual frame buffer.
xvfb-run gulp test

# Create a version number file.
echo "$1 build $2" > build/version

popd
