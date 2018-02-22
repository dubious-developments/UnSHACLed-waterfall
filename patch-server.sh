#!/usr/bin/env bash

current_dir_path=$(dirname $0)

pushd $current_dir_path/UnSHACLed-server

echo $1 | sudo --stdin cp sites-enabled-default /etc/nginx/sites-available/default
echo $1 | sudo --stdin service nginx reload

popd
