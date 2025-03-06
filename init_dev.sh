#!/bin/bash

if [ ! -f ./synapse-data/homeserver.yaml ]; then
  wget -qO- https://raw.githubusercontent.com/gscafo78/setup/main/inizialsetup/install_docker.sh | bash
  docker compose run --rm synapse generate
  echo "Now, update the .env file with the new data, then run this script once."
else
  apt update -y
  apt install gettext-base -y
  export $(grep -v '^#' ./.env | xargs)
  envsubst < ./coturn/turnserver.template.conf > ./coturn/turnserver.conf
  envsubst < ./homeserver.template.yaml > ./synapse-data/homeserver.yaml
  envsubst < ./element-config.template.json > ./element-config.json
  openssl req -x509 -newkey rsa:4096 -keyout ./letsencrypt/privkey.pem -out ./letsencrypt/fullchain.pem -days 3650 -nodes -subj "/CN=${COTURN_SERVER_NAME}"
  
  # Clona le regole OWASP CRS
  git clone https://github.com/coreruleset/coreruleset ./modsec/crs
  # Crea le directory necessarie
  mkdir -p ./modsec/{conf,crs,custom-rules,data}
  # Sostituisci la configurazione CRS
  cp ./modsec/crs/crs-setup.conf.example ./modsec/crs/crs-setup.conf
fi
