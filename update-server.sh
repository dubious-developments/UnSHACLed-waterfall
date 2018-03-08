#!/usr/bin/env bash

current_dir_path=$(dirname $0)
subdirectory=$1
subdirectory_remote=$2
subdirectory_branch=$3

pushd "$current_dir_path/$subdirectory"

# Pull in the latest sources.
git pull $subdirectory_remote $subdirectory_branch
git submodule update --init --recursive --remote

popd
