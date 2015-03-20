#! /bin/bash

# Script to install and update to the latest version of docker from docker.com

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
apt-get update
apt-get install lxc-docker
