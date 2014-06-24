#!/bin/bash

# import common env values.
source /vagrant/env.sh

# the folder where logstash is installed 
LOGSTASH_BASE="${SVCS_HOME}/logstash"

# logstash version
LOGSTASH_VERSION="1.4.1"

# the name of the file to download
LOGSTASH_FILE="https://download.elasticsearch.org/logstash/logstash/logstash-${LOGSTASH_VERSION}.tar.gz"
