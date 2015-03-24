#!/bin/bash

scriptname=`basename $0`
arguments="SITE_NAME"
purpose="This script is for creating a new self signed certificate without a passphrase."
example="sudo ./$scriptname wiki.gistlabs.com"


argcount=`wc -w <<< $arguments`

if [ $# -ne $argcount ]
then
    	echo "Arguments missing!"
	echo
    	echo "Usage: $scriptname $arguments"
	echo
	echo "EXAMPLE: $example"
	echo 
	echo $purpose
	echo
    exit 1
fi

site=$1

openssl req  -new -x509 -sha256 -newkey rsa:2048 -nodes \
    -keyout ${site}.key.pem -days 365 -out ${site}.cert.pem
