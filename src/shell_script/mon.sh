#!/bin/sh
while true
do
   /bin/sh /usr/local/boobooke/http.sh > /dev/null 2>&1
   /bin/sh /usr/local/boobooke/tcp.sh > /dev/null 2>&1
   sleep 10
done

