#!/bin/bash
#
#       /etc/rc.d/init.d/
#
# Starts the at daemon
#
# chkconfig: 345 100 105
# description: mprobe_mail
# processname: sysbase

# Source function library.
. /etc/init.d/functions

test -x /root/lib/mail/mprobe_mail ||  exit 0

RETVAL=0

#
#       See how we were called.
#

prog="mprobe_mail"

start() {
        # Check if programe is already running
        if [ ! -f /var/lock/subsys/mprobe_mail ]; then
            echo -n $"Starting $prog: "
            /root/lib/mail/mprobe_mail >/dev/null 2>&1
            RETVAL=$?
            [ $RETVAL -eq 0 ] && touch /var/lock/subsys/mprobe_mail
            echo
        fi
        return $RETVAL
}

stop() {
        echo -n $"Stopping $prog: "
        killall mprobe_mail
        RETVAL=$?
        [ $RETVAL -eq 0 ] && rm -f /var/lock/subsys/mprobe_mail
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
        ps -e |grep mprobe_mail
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