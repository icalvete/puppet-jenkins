#!/bin/bash

DOMAIN=$1

keytool -importkeystore -srckeystore jenkins_keystore.p12 \
	-srcstorepass 'j3nk1nsk3y' -srcstoretype PKCS12 \
	-srcalias $DOMAIN -deststoretype JKS \
	-destkeystore jenkins_keystore.jks -deststorepass 'j3nk1nsk3y' \
	-destalias $DOMAIN
