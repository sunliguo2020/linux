#!/bin/bash
#
#       /etc/rc.d/init.d/
#
# Starts the at daemon
#
# chkconfig: 345 100 105
# description: sysbased
# processname: sysbased

# Source function library.
. /etc/init.d/functions

test -x /opt/sybase/ASE-15_0/install/RUN_LOCALHOST || exit 0

RETVAL=0

#
#       See how we were called.
#

prog="RUN_LOCALHOST"

start() {
        # Check if programe is already running
        if [ ! -f /var/lock/subsys/sysbased ]; then
            echo -n $"Starting $prog: "		
			
            /opt/sybase/ASE-15_0/install/RUN_LOCALHOST >/root/syabase.log 2>&1
            RETVAL=$?
            [ $RETVAL -eq 0 ] && touch /var/lock/subsys/sysbased
            echo
        fi
        return $RETVAL
}

stop() {
        echo -n $"Stopping $prog: "
        killall dataserver
        RETVAL=$?
        [ $RETVAL -eq 0 ] && rm -f /var/lock/subsys/sysbased
        echo
        return $RETVAL
}


restart() {
        stop
        start
}

reload() {
        restart
}

status_at() {
        ps -e |grep dataserver
		netstat -ntlp |grep 5000
}

case "$1" in
start)
        start
        ;;
stop)
        stop
        ;;
reload|restart)
        restart
        ;;
status)
        status_at
        ;;
*)
        echo $"Usage: $0 {start|stop|restart|condrestart|status}"
        exit 1
esac

exit $?
exit $RETVAL
