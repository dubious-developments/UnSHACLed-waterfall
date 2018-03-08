#!/usr/bin/env bash

# NOTE: this script should only be run on a Travis CI box. Do not run it locally
# if you like your computer, because it'll screw up your settings.
#
# This script also implicitly depends on the Travis CI build number and a number
# of secret CI variables, so it'll almost certainly crash and burn if you try to
# run it on a normal machine (unless you go to great lengths to make it work,
# but you really shouldn't).

set -e

ENCRYPTED_PEM_KEY=$1
ENCRYPTED_PEM_IV=$2
DEPLOY_HOST_PORT=$3
DEPLOY_NAME=$4
NIGHTLY=$5

if [ ! -z "$NIGHTLY" ]; then
  APP_NAME="$NIGHTLY"
else
  APP_NAME="UnSHACLed"
fi

# Decrypt login certificate.
openssl aes-256-cbc -K $ENCRYPTED_PEM_KEY -iv $ENCRYPTED_PEM_IV -in cert.pem.enc -out cert.pem -d
sudo chmod 600 cert.pem

# Be gullible wrt the authenticity of hosts.
echo "StrictHostKeyChecking no" | sudo tee -a /etc/ssh/ssh_config

# Have the host update, clean, build and patch the server.
export SSHPASS=$DEPLOY_PASS
sshpass -e -Passphrase ssh -A -i cert.pem $DEPLOY_USER@$DEPLOY_HOST -oPort=$DEPLOY_PORT $DEPLOY_PATH/update-server.sh
sshpass -e -Passphrase ssh -A -i cert.pem $DEPLOY_USER@$DEPLOY_HOST -oPort=$DEPLOY_PORT $DEPLOY_PATH/clean-server.sh
if [ ! -z "$NIGHTLY" ]; then
  # Grab the latest version of the UnSHACLed server master branch.
  sshpass -e -Passphrase ssh -A -i cert.pem $DEPLOY_USER@$DEPLOY_HOST -oPort=$DEPLOY_PORT \
  $DEPLOY_PATH/update-server.sh UnSHACLed-server https://github.com/dubious-developments/UnSHACLed-server master;

  # Grab the latest version of the UnSHACLed client master branch.
  sshpass -e -Passphrase ssh -A -i cert.pem $DEPLOY_USER@$DEPLOY_HOST -oPort=$DEPLOY_PORT \
  $DEPLOY_PATH/update-server.sh UnSHACLed-server/UnSHACLed https://github.com/dubious-developments/UnSHACLed master;
fi
sshpass -e -Passphrase ssh -A -i cert.pem $DEPLOY_USER@$DEPLOY_HOST -oPort=$DEPLOY_PORT $DEPLOY_PATH/build-server.sh "$APP_NAME" $TRAVIS_BUILD_NUMBER
sshpass -e -Passphrase ssh -A -i cert.pem $DEPLOY_USER@$DEPLOY_HOST -oPort=$DEPLOY_PORT $DEPLOY_PATH/patch-server.sh $DEPLOY_PASS $DEPLOY_HOST_PORT $DEPLOY_NAME
