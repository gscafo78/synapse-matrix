#!/bin/bash

if [ ! -f ./synapse-data/homeserver.yaml ]; then
  echo "You have to run first 'docker compose run --rm synapse-init'" 
else
  apt update -y
  apt install gettext-base -y
  export $(grep -v '^#' ./.env | xargs)
  envsubst < ./coturn/turnserver.template.conf > ./coturn/turnserver.conf
  envsubst < ./homeserver.template.yaml > ./synapse-data/homeserver.yaml
  envsubst < ./element-config.template.json > ./element-config.json
fi