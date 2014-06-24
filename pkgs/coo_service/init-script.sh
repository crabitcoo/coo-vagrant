#!/bin/bash
#
# chkconfig: 35 90 12
# description: @@coo-service-name@@

# Get function from functions library
. /etc/init.d/functions

# import specific env values.
source @@pkg-dir@@/env.sh


# Start the service
start() {
    cd @@coo-services-home@@/@@coo-service-name@@ && daemon --user ${COO_USER_NAME} java -jar -Dspring.profiles.active=prod @@coo-services-home@@/@@coo-service-name@@/@@coo-service-file@@ &
    success $"@@coo-service-name@@ started"
    echo
}

# Stop the service
stop() {
        success $"@@coo-service-name@@ stop not supported"
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
        status @@coo-service-name@@
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
