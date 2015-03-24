#!/bin/bash

scriptname=`basename $0`
arguments="WIKI_ROOT"
purpose="This script is for deleting wiki deployments.  It will not remove host-bound data volumes."
example="sudo ./$scriptname gistlabs"

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

wiki_container=${siteroot}_gollum_wiki
wiki_editable_container=${wiki_container}_editable

docker stop $wiki_container
docker stop $wiki_editable_container

docker rm -v $wiki_container
docker rm -v $wiki_editable_container
