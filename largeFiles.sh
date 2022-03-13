#!/usr/bin/env bash

LARGER_FILES=${LARGER_FILES:-false}
MAX_DOWNOAD_SIZE=${MAX_DOWNLOAD_SIZE:-104857600}
MAX_UNCOMPRESSED_SIZE=${MAX_UNCOMPRESSED_SIZE:-300}
if [ "$LARGER_FILES" = true ]; then

	sed -i -e "s/104857600/${MAX_DOWNLOAD_SIZE}/g" /etc/onlyoffice/documentserver-example/production-linux.json

	sed -i "9iclient_max_body_size ${MAX_DOWNLOAD_SIZE};" /etc/onlyoffice/documentserver-example/nginx/includes/ds-example.conf
	sed -i "16iclient_max_body_size ${MAX_DOWLOAD_SIZE};" /etc/nginx/nginx.conf

	sed -i -e "s/104857600/${MAX_DOWNLOAD_SIZE}/g" /etc/onlyoffice/documentserver/default.json
	sed -i -e "s/50MB/${MAX_UNCOMPRESSED_SIZE}MB/g" /etc/onlyoffice/documentserver/default.json
	sed -i -e "s/300MB/${MAX_UNCOMPRESSED_SIZE}MB/g" /etc/onlyoffice/documentserver/default.json

	sed -i "s/^client_max_body_size 100m;$/client_max_body_size ${MAX_DOWNLOAD_SIZE};/" /etc/onlyoffice/documentserver/nginx/includes/ds-common.conf
fi

touch /app/ds/largeFiles.lck
#service nginx restart
#supervisorctl restart all
