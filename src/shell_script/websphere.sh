#!/bin/bash
#
#       /etc/rc.d/init.d/
#
# Starts the at daemon
#
# chkconfig: 345 100 105
# description: websphered
# processname: websphered

# Source function library.
. /etc/init.d/functions

test -x  || exit 0

RETVAL=0

#
#       See how we were called.
#

prog="java"

start() {
        # Check if programe is already running
        if [ ! -f /var/lock/subsys/websphered ]; then
            echo -n $"Starting $prog: "
			#判断 sysbase 是否已经启动起来了
			ip=192.168.1.202;
			port=5000;
			while test 0 -eq 0;do
        		nmap -n -sS -p $port $ip --max_rtt_timeout 100 | grep open >/dev/null 2>/dev/null;
        		if test $? -eq 0;then
               		  echo  "sysbase is running-------"
                        killall java
                        cd /opt/IBM/WebSphere/AppServer/bin
                        ./startServer.sh server1
                        break;
				else
					echo "sleeping------"
					sleep 10
       			 fi
			done
            RETVAL=$?
            [ $RETVAL -eq 0 ] && touch /var/lock/subsys/websphered
            echo
			else
			 
        fi
        return $RETVAL
}

stop() {
        echo -n $"Stopping $prog: "
        killall java
        RETVAL=$?
        [ $RETVAL -eq 0 ] && rm -f /var/lock/subsys/websphered
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
		netstat -ntlp |grep java
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
