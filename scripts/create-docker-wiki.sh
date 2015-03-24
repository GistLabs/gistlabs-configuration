#!/bin/bash

scriptname=`basename $0`
arguments="WIKI_ROOT_NAME WIKI_PORT WIKI_EDIT_PORT DOCKER_DATA_VOLUMES_DIRECTORY"
purpose="This script is for creating a new gollum wiki. If DOCKER_DATA_VOLUMES_DIRECTORY exists for this wiki it will be used, otherwise it will be created."

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
wiki_port=$2
wiki_edit_port=$3
docker_data_volumes=$4

wiki_container=${siteroot}_gollum_wiki
wiki_editable_container=${wiki_container}_editable
wiki_data_volume=${docker_data_volumes}/${siteroot}/gollum_wiki

mkdir -p $wiki_data_volume
git init $wiki_data_volume

#Editable
sudo docker run --name $wiki_container -d -p $wiki_edit_port:4567 -v $wiki_data_volume:/root/wikidata gistlabs/gollum --allow-uploads

#Readonly
sudo docker run --name $wiki_editable_container -d -p $wiki_port:4567 -v $wiki_data_volume:/root/wikidata gistlabs/gollum --no-edit
