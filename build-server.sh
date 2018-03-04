#!/usr/bin/env bash

current_dir_path=$(dirname $0)

pushd "$current_dir_path/UnSHACLed-server/UnSHACLed"
# Download dependencies.
npm install

# Build the client.
gulp build

# Create a version number file.
echo "UnSHACLed build $1" > build/version

popd
