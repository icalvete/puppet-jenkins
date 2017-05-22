#!/bin/bash

KEY=$1
CRT=$2
CA_CRT=$3
DOMAIN=$4

openssl pkcs12 -export -out jenkins_keystore.p12 \
	-passout 'pass:j3nk1nsk3y' -inkey $KEY \
	-in $CRT -certfile $CA_CRT -name $DOMAIN
