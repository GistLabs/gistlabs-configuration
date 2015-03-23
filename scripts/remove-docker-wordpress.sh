#!/bin/bash

scriptname=`basename $0`
arguments="WP_ROOT"
purpose="This script is for deleting wordpress/mysql deployments.  It will not affect the data volumes."

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

wp_container=${siteroot}_wp
mysql_container=${siteroot}_mysql

docker stop $wp_container
docker stop $mysql_container

docker rm -v $wp_container
docker rm -v $mysql_container
