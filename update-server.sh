#!/usr/bin/env bash

current_dir_path=$(dirname $0)

pushd "$current_dir_path"

# Pull in the latest sources.
git pull
git submodule update --init --recursive --remote

popd
