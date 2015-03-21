#!/bin/bash

scriptname=`basename $0`
arguments="WP_ROOT_NAME WP_PORT MYSQL_ROOT_PASSWORD VOLUMES_DIRECTORY"
purpose="This script is for creating a new wordpress set of docker containers. If volumes exist for this wordpress root in the VOLUMES_DIRECTORY, they will be used, otherwise they will be created." "

argcount=`wc -w <<< $arguments`

if [ $# -ne $argcount ]
then
    echo "Arguments missing!"
    echo "Usage: $scriptname $arguments"
	echo 
	echo $purpose
    exit 1
fi

siteroot=$1
wp_port=$2
mysqlpass=$3
volumes_directory=$4

wp_data_volume=$volumes_directory/${siteroot}/wordpress
mysql_data_volume=$volumes_directory/${siteroot}/mysql
wp_container=${siteroot}_wp
mysql_container=${siteroot}_mysql

mkdir -p $wp_data_volume
mkdir -p $mysql_data_volume:

docker run --name $mysql_container \
	   --volume $mysql_data_volume:/var/lib/mysql \
	   -e MYSQL_ROOT_PASSWORD=$mysqlpass \
	   -d mysql

# Give it a chance to spin up
sleep 1

docker run --name $wp_container \
	   -p $wp_port:80 \
	   --link $mysql_container:mysql \
           --volume $wp_data_volume:/var/www/html \
           -d migratable-wordpress

