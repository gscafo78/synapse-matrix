#!/bin/bash

apt update -y
apt install gettext-base -y
export $(grep -v '^#' ./.env | xargs)
envsubst < ./coturn/turnserver.conf.template > ./coturn/turnserver.conf
envsubst < ./homeserver.yaml.template > ./homeserver.yaml