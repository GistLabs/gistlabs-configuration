#!/bin/bash

scriptname=`basename $0`
arguments="WP_ROOT_NAME WP_PORT MYSQL_ROOT_PASSWORD VOLUMES_DIRECTORY"

argcount=`wc -w <<< $arguments`

if [ $# -ne $argcount ]
then
    echo "Arguments missing!"
    echo "Usage: $scriptname $arguments"
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

if [ -e $wp_data_volume ]
then
	echo
	echo "ERROR: Wordpress Data Volume already exists"
	echo
 	echo "$wp_data_volume"
	echo
	echo "Delete and try again"
	echo
	exit 1
fi

if [ -e $mysql_data_volume ]
then
	echo
	echo "ERROR: MySQL Data Volume already exists."
	echo
	echo "$mysql_data_volume"
	echo
	echo "Delete and try again"
	echo
	exit 1
fi

mkdir -p $wp_data_volume
mkdir -p $mysql_data_volume

`dirname $0`/create-docker-wordpress.sh
