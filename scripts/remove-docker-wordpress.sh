#!/bin/bash

scriptname=`basename $0`
arguments="WP_ROOT"
purpose="This script is for deleting wordpress/mysql deployments.  It will not remove host-bound the data volumes."
example="sudo /.${scriptname} conretereflective"

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

wp_container=${siteroot}_wp
mysql_container=${siteroot}_mysql

docker stop $wp_container
docker stop $mysql_container

docker rm -v $wp_container
docker rm -v $mysql_container
