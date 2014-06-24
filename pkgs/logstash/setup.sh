#!/bin/bash

# import common env values.
source $1/env.sh

# install logstash
sudo -u ${COO_USER_NAME} -H mkdir -p ${LOGSTASH_BASE} && cd ${LOGSTASH_BASE}

LOGSTASH_TGZ="logstash-${LOGSTASH_VERSION}.tar.gz"

# install logstash
if [ -f /vagrant/.cache/$LOGSTASH_TGZ ];
then
   echo "file $LOGSTASH_TGZ exists, continuing to installation"
else
   echo "File $LOGSTASH_TGZ does not exists, downloading now..."
   wget $LOGSTASH_FILE -O /vagrant/.cache/$LOGSTASH_TGZ
fi

sudo -u ${COO_USER_NAME} -H tar xzpf /vagrant/.cache/$LOGSTASH_TGZ -C ${LOGSTASH_BASE}
sudo -u ${COO_USER_NAME} -H mv logstash-${LOGSTASH_VERSION} ${LOGSTASH_VERSION}

sudo -u ${COO_USER_NAME} -H ln -s "${LOGSTASH_BASE}/${LOGSTASH_VERSION}" ${CURR_V_SYMLINK}

LOGSTASH_HOME="${LOGSTASH_BASE}/${CURR_V_SYMLINK}"

sudo -u ${COO_USER_NAME} -H cp $1/logstash.conf "${LOGSTASH_HOME}/"

sudo sed -i 's|@@coo-services-home@@|'${SVCS_HOME}'|g' "${LOGSTASH_HOME}/logstash.conf"
sudo sed -i 's|@@coo-service-name@@|'$2'|g' "${LOGSTASH_HOME}/logstash.conf"
sudo sed -i 's|@@coo-monitor-service-ip@@|'$3'|g' "${LOGSTASH_HOME}/logstash.conf"

cp $1/init-script.sh /etc/init.d/logstash

sudo sed -i 's|@@pkg-dir@@|'$1'|g' /etc/init.d/logstash

chmod +x /etc/init.d/logstash

chkconfig --add logstash
chkconfig logstash on

service logstash start
