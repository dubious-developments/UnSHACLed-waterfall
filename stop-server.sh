#!/usr/bin/env bash

echo $1 | sudo --stdin service nginx stop
