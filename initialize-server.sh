#!/bin/bash

scriptname=`basename $0`
purpose="This script is for installing the gistlabs server. It should be part of a package that lives in the /home/common directory."

directory=$( cd "$( dirname "$0" )/.." && pwd )
docker_volumes=$directory/docker-data-volumes
conf_dir=$directory/gistlabs-configuration
unmanaged=$directory/unmanaged

# INSTALL NECESSARY SOFTWARE
apt-get install -y nginx-core
apt-get install -y apache2-utils

# INSTALL LATEST DOCKER
$conf_dir/scripts/install-docker-on-ubuntu.sh

# BUILD CUSTOM DOCKER IMAGES SO INSTALLATION SCRIPTS WILL WORK
docker build -t gistlabs/gollum:latest $conf_dir/docker-images/gollum-3.1.2/
docker build -t gistlabs/wordpress:latest $conf_dir/docker-images/migratable-wordpress

# INSTALL DOCKER CONTAINERS
$unmanaged/scripts/create-gistlabs-wiki.sh
$unmanaged/scripts/create-concretereflective-wp.sh
$unmanaged/scripts/create-gistlabs-wp.sh

# LINK TO NGINX CONFIGURATIONS AND RELOAD
ln -sf $conf_dir/etc/nginx/sites-available/* /etc/nginx/sites-enabled/
/etc/init.d/nginx restart

# REPLACE DOCKER CONF WITH ONE THAT STOPS CONTAINERS GRACEFULLY AND RELOAD
mv /etc/init/docker.conf /etc/init/docker.conf.bak
ln -sf $conf_dir/etc/init/docker.conf /etc/init/
initctl reload-configuration

echo "server ready"


