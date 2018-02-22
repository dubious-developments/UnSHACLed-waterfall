#!/usr/bin/env bash

current_dir_path=$(dirname $0)

bash $current_dir_path/update-server.sh
bash $current_dir_path/build-server.sh
