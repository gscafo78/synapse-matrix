#!/bin/bash

# Insert the domain and email
read -p "Write the email: " email
read -p "write the domain: " domain

mkdir -p certbot/letsencrypt \
            waf/logs \
            www \
            waf/conf.d \
            waf/user-rules \
            certbot/logs

docker compose -f docker-compose_stable.yml up -d waf-nginx

#docker run --rm \
#            -v $(pwd)/certbot/letsencrypt:/etc/letsencrypt \
#            -v $(pwd)/www:/var/www/certbot \
#            4ss078/certbot:latest certonly --webroot -w /var/www/certbot \
#            --email $email --agree-tos --no-eff-email -d $domain

#docker compose -f docker-compose_stable.yml down waf-nginx
