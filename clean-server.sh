#!/usr/bin/env bash

set -e

current_dir_path=$(dirname $0)

pushd $current_dir_path

# Undo any and all local changes, build products, etc.
# We should end up with a pristine waterfall repository.
git reset --hard
git submodule foreach --recursive git reset --hard
git clean -fdx .
git submodule foreach --recursive git clean -fdx .

popd
