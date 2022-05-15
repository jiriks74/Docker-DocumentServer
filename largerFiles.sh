#!/bin/bash

echo "What's the name of your container? (default value: 'onlyoffice_documentserver')"
read container_name

if [ "$container_name" = "" ]; then
   container_name="onlyoffice_documentserver"
fi;

docker exec -it $container_name "/bin/sh -c 'sed -i -e 's/104857600/10485760000/g' /etc/onlyoffice/documentserver-example/production-linux.json'"

docker exec -it $container_name  "/bin/sh -c 'sed -i '9iclient_max_body_size 1000M;' /etc/onlyoffice/documentserver-example/nginx/includes/ds-example.conf'"
docker exec -it $container_name  "/bin/sh -c 'sed -i '16iclient_max_body_size 1000M;' /etc/nginx/nginx.conf'"

docker exec -it $container_name  "/bin/sh -c 'sed -i -e 's/104857600/10485760000/g' /etc/onlyoffice/documentserver/default.json'"
docker exec -it $container_name  "/bin/sh -c 'sed -i -e 's/50MB/5000MB/g' /etc/onlyoffice/documentserver/default.json'"
docker exec -it $container_name  "/bin/sh -c 'sed -i -e 's/300MB/3000MB/g' /etc/onlyoffice/documentserver/default.json'"

docker exec -it $container_name  "/bin/sh -c 'sed -i 's/^client_max_body_size 100m;$/client_max_body_size 1000m;/' /etc/onlyoffice/documentserver/nginx/includes/ds-common.conf'"

docker exec -it $container_name  "/bin/sh -c 'service nginx restart'"
docker exec -it $container_name  "/bin/sh -c 'supervisorctl restart all'"
