#!/bin/bash

# import common env values.
source $1/env.sh

# the folder where the service is installed 
SVC_BASE="${SVCS_HOME}/$2"

sudo -u ${COO_USER_NAME} -H mkdir -p ${SVC_BASE} && cd ${SVC_BASE}

SVC_JAR="$2-$3.jar"

if [ -f /vagrant/.cache/$SVC_JAR ];
then
   echo "file $SVC_JAR exists, continuing to installation"
else
   echo "File $SVC_JAR does not exists, downloading now..."
   wget "$BINTRAY/coo/$2/$3/$SVC_JAR" -O /vagrant/.cache/$SVC_JAR
fi

sudo -u ${COO_USER_NAME} -H cp /vagrant/.cache/$SVC_JAR $SVC_BASE

sudo cp $1/init-script.sh /etc/init.d/coo

sudo sed -i 's|@@coo-services-home@@|'${SVCS_HOME}'|g' /etc/init.d/coo
sudo sed -i 's|@@coo-service-name@@|'$2'|g' /etc/init.d/coo
sudo sed -i 's|@@coo-service-file@@|'$SVC_JAR'|g' /etc/init.d/coo
sudo sed -i 's|@@pkg-dir@@|'$1'|g' /etc/init.d/coo

sudo chmod +x /etc/init.d/coo

chkconfig --add coo
chkconfig coo on

service coo start
