#!/usr/bin/env bash

# Pull in the latest sources.
git pull
git submodule update --init --recursive --remote
