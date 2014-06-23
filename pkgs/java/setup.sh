#!/bin/bash

# import common env values.
source $1/env.sh

JAVA_RPM=jdk-8u5-linux-x64.rpm

if [ -f /vagrant/.cache/$JAVA_RPM ];
then
   echo "file $JAVA_RPM exists, continuing to installation"
else
   echo "File $JAVA_RPM does not exists, downloading now..."
   wget --no-cookies \
    --no-check-certificate \
    --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    "http://download.oracle.com/otn-pub/java/jdk/8u5-b13/jdk-8u5-linux-x64.rpm" \
    -O /vagrant/.cache/$JAVA_RPM
fi

sudo rpm -i /vagrant/.cache/$JAVA_RPM
