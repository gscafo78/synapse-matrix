#!/bin/bash

if [ ! -f ./synapse-data/homeserver.yaml ]; then
  docker compose run --rm synapse generate
  echo "Now, update the .env file with the new data, then run this script once."
else
  apt update -y
  apt install gettext-base -y
  export $(grep -v '^#' ./.env | xargs)
  envsubst < ./coturn/turnserver.template.conf > ./coturn/turnserver.conf
  envsubst < ./homeserver.template.yaml > ./synapse-data/homeserver.yaml
  envsubst < ./element-config.template.json > ./element-config.json
  openssl req -x509 -newkey rsa:4096 -keyout ./coturn/privkey.pem -out ./coturn/fullchain.pem -days 3650 -nodes -subj "/CN=${COTURN_SERVER_NAME}"
fi
