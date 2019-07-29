#!/bin/sh

if [ -z "$QUEUE_CONNECTION" ]; then
	QUEUE_CONNECTION="redis"
fi

if [ -z "$QUEUE_NAME" ]; then
	QUEUE_NAME="default"
fi

PHP_MEMORY_LIMIT=${PHP_MEMORY_LIMIT:-512}
RETRIES=${RETRIES:-5}
TIMEOUT=${TIMEOUT:-60}
WORKER_AMOUNT=${WORKER_AMOUNT:-5}


sed -e "s~%%MEMORY_LIMIT%%~${PHP_MEMORY_LIMIT}m~" \
    /opt/etc/custom-php.ini.tpl > /usr/local/etc/php/conf.d/custom-php.ini

sed -e "s~%%QUEUE_CONNECTION%%~$QUEUE_CONNECTION~" \
	-e "s~%%QUEUE_NAME%%~$QUEUE_NAME~" \
	-e "s~%%MEMORY_LIMIT%%~$PHP_MEMORY_LIMIT~" \
	-e "s~%%RETRIES%%~$RETRIES~" \
	-e "s~%%TIMEOUT%%~$TIMEOUT~" \
	-e "s~%%WORKER_AMOUNT%%~$WORKER_AMOUNT~" \
	/etc/supervisor/conf.d/laravel-worker.conf.tpl > /etc/supervisor/supervisord.conf


supervisord --nodaemon --configuration /etc/supervisor/supervisord.conf
