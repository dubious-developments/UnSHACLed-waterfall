#!/usr/bin/env bash

current_dir_path=$(dirname $0)

pushd "$current_dir_path/UnSHACLed-server"

./patch-server.sh "$current_dir_path/UnSHACLed-server/UnSHACLed" $2
echo $1 | sudo --stdin ./install-server.sh
echo $1 | sudo --stdin service nginx reload

popd
