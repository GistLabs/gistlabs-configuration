#!/bin/bash

scriptname=`basename $0`
arguments="WP_ROOT_NAME WP_PORT MYSQL_ROOT_PASSWORD VOLUMES_DIRECTORY"
purpose="This script is for creating a new wordpress set of docker containers (one wordpress and one mysql). If volumes exist for this wordpress root in the VOLUMES_DIRECTORY, they will be used, otherwise they will be created."
example="sudo ./create-docker-wordpress.sh concretereflective 8881 supersecret58239843 /home/common/docker-data-volumes/"

argcount=`wc -w <<< $arguments`

if [ $# -ne $argcount ]
then
	echo
    	echo "Arguments missing!"
    	echo
	echo "USAGE: $scriptname $arguments"
	echo 
	echo "EXAMPLE: $example"
	echo
	echo $purpose
	echo
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
	   --restart="always" \
	   --volume $mysql_data_volume:/var/lib/mysql \
	   -e MYSQL_ROOT_PASSWORD=$mysqlpass \
	   -d mysql

# Give it a chance to spin up
sleep 1

docker run --name $wp_container \
	   --restart="always" \
	   -p $wp_port:80 \
	   --link $mysql_container:mysql \
           --volume $wp_data_volume:/var/www/html \
           -d gistlabs/wordpress

