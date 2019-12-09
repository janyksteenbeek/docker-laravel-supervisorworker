FROM php:7.4-alpine

LABEL maintainer="Janyk Steenbeek <info@janyksteenbeek.nl>" \
		version.image="v0.2" \
		version.php=$PHP_VERSION \
		description="A supervisord container configured to run with Laravel artisan queue workers on PHP 7.4"

ENV QUEUE_CONNECTION=redis
ENV QUEUE_NAME=default

# Install all dependencies and continue to install Supervisor
RUN apk --no-cache add pcre-dev ${PHPIZE_DEPS} \ 
	&& apk add --update libxml2-dev oniguruma-dev \
	&& pecl install -o -f redis \
	&& docker-php-ext-install pdo pdo_mysql pcntl posix soap tokenizer json xml mbstring \
	&& docker-php-ext-enable redis \
	&& apk add --update supervisor \
        && apk del pcre-dev ${PHPIZE_DEPS} \
	&& rm -rf /tmp/* /var/cache/apk/*

# Define working directory
WORKDIR /etc/supervisor/conf.d

# Use local configuration
COPY laravel-worker.conf.tpl /etc/supervisor/conf.d/laravel-worker.conf.tpl
COPY custom-php.ini.tpl /opt/etc/custom-php.ini.tpl

# Copy scripts
COPY init.sh /usr/local/bin/init.sh

VOLUME /var/www/app

# Run supervisor
ENTRYPOINT ["/bin/sh", "/usr/local/bin/init.sh"]
