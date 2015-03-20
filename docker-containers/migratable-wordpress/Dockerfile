FROM wordpress

MAINTAINER Joshua Reynolds <josh@gistlabs.com> 

# Need to install the PHP extensions necessary for the All-in-One WP Migration plugin.
# Available here: https://wordpress.org/plugins/all-in-one-wp-migration/

RUN docker-php-ext-install mysql
RUN docker-php-ext-install zip

