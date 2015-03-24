#!/bin/bash

scriptname=`basename $0`
arguments="WIKI_ROOT"
purpose="This script is for deleting wiki deployments.  It will not affect the data volumes."

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

wiki_container=${siteroot}_gollum_wiki
wiki_editable_container=${wiki_container}_editable

docker stop $wiki_container
docker stop $wiki_editable_container

docker rm -v $wiki_container
docker rm -v $wiki_editable_container
