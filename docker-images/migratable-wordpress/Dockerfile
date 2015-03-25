FROM wordpress

MAINTAINER Joshua Reynolds <josh@gistlabs.com> 

# Need to install the PHP extensions necessary for the All-in-One WP Migration plugin.
# Available here: https://wordpress.org/plugins/all-in-one-wp-migration/

RUN docker-php-ext-install mysql zip

#And the ones for Really Simple Captch

RUN apt-get update && apt-get install -y php5-gd libfreetype6-dev

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/freetype
RUN docker-php-ext-install gd

