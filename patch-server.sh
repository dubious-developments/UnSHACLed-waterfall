#!/usr/bin/env bash

current_dir_path=$(dirname $0)

pushd $current_dir_path/UnSHACLed-server

./patch-server.sh $2 $3
echo $1 | sudo --stdin ./install-server.sh
echo $1 | sudo --stdin service nginx reload

popd
