#!/bin/bash
#
# chkconfig: 35 90 12
# description: logstash

# Get function from functions library
. /etc/init.d/functions

# import specific env values.
source @@pkg-dir@@/env.sh


# Start the service
start() {
        daemon ${LOGSTASH_BASE}/${CURR_V_SYMLINK}/bin/logstash -f ${LOGSTASH_BASE}/${CURR_V_SYMLINK}/logstash.conf &
        success $"logstash started"
        echo
}

# Stop the service
stop() {
        success $"logstash stop not supported"
        echo
}

### main logic ###
case "$1" in
  start)
        start
        ;;
  stop)
        stop
        ;;
  status)
        status logstash
        ;;
  restart|reload|condrestart)
        stop
        start
        ;;
  *)
        echo $"Usage: $0 {start|stop|restart|reload|status}"
        exit 1
esac
exit 0
