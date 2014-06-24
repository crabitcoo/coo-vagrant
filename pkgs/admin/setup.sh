#!/bin/bash

# import common env values.
source $1/env.sh

# stop the firewall 
service iptables stop
chkconfig iptables off

# create the coo user
useradd -m -U -s /bin/bash ${COO_USER_NAME}
echo "${COO_USER_NAME}:${COO_USER_PASSWORD}" | chpasswd

# prepare the apps folder
mkdir ${APPS_HOME}
chown "${COO_USER_NAME}:${COO_USER_NAME}" ${APPS_HOME}

# prepare the services folder
mkdir ${SVCS_HOME}
chown "${COO_USER_NAME}:${COO_USER_NAME}" ${SVCS_HOME}
