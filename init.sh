#!/bin/bash

apt update -y
apt install gettext-base -y
export $(grep -v '^#' ./.env | xargs)
envsubst < ./coturn/turnserver.template.conf > ./coturn/turnserver.conf
envsubst < ./homeserver.template.yaml > ./homeserver.yaml
envsubst < ./element-config.template.json > ./element-config.json