#!/bin/bash

# import common env values.
source $1/env.sh

ES_RPM=elasticsearch-${ES_VERSION}.rpm

# install elasticsearch
if [ -f /vagrant/.cache/$ES_RPM ];
then
   echo "file $ES_RPM exists, continuing to installation"
else
   echo "File $ES_RPM does not exists, downloading now..."
   wget $ES_FILE -O /vagrant/.cache/$ES_RPM
fi

sudo rpm -i /vagrant/.cache/$ES_RPM

sudo /sbin/chkconfig --add elasticsearch
sudo service elasticsearch start
