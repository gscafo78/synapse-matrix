#!/bin/bash

# Controllo se la variabile d'ambiente TOKEN_ADMIN è impostata
if [ -z "$TOKEN_ADMIN" ]; then
    echo "Errore: la variabile d'ambiente TOKEN_ADMIN non è impostata."
    exit 1
fi

# Inizializzazione delle variabili
temp_name=""
temp_surname=""

# Parsing degli argomenti
while getopts "n:s:" opt; then
  case $opt in
    n) temp_name="$OPTARG"
    ;;
    s) temp_surname="$OPTARG"
    ;;
    \?) echo "Uso: $0 -n <Nome> -s <Cognome>"
        exit 1
    ;;
  esac
done

# Controllo se sono stati passati entrambi gli argomenti
if [ -z "$temp_name" ] || [ -z "$temp_surname" ]; then
    echo "Uso: $0 -n <Nome> -s <Cognome>"
    exit 1
fi

# Formattazione nome e cognome
name="$(echo "${temp_name:0:1}" | tr '[:lower:]' '[:upper:]')$(echo "${temp_name:1}" | tr '[:upper:]' '[:lower:]')"
surname="$(echo "$temp_surname" | tr '[:upper:]' '[:lower:]')"

# Generazione username
user="${surname}_$(echo "${name:0:1}" | tr '[:upper:]' '[:lower:]')"

echo "Creazione dell'utente: $user"

# Creazione dell'utente con il comando Docker
docker compose exec -it synapse bash -c "register_new_matrix_user -u $user -p changeme! --no-admin -c /data/homeserver.yaml http://127.0.0.1:8008"

echo "Utente creato con successo: $user"

# Modifica del display name con cURL
curl -X POST "http://127.0.0.1:8008/_synapse/admin/v2/users/@$user:matrixacd.duckdns.org" \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $TOKEN_ADMIN" \
    -d "{\"displayname\": \"$name $surname\"}"

echo "Display name aggiornato: $name $surname"