#!/bin/bash
#by galf & lxmxn

(echo -e "USERNAME\tTTY\tIP\tLOCATION ADDRESS";for ((i=0;i<50;i++));do echo -n '--'; done ; echo ;
w | sed '1,2d' | while read username tty ip other; do echo -e "$username\t$tty\t$ip\t`curl -s \
"http://www.youdao.com/smartresult-xml/search.s?type=ip&q=$ip" | iconv -f gbk -t utf8 | sed -n '3p' | \
sed -r 's/.*<location>([^<]*)<\/location>.*/\1/'`"; done) | expand -t 24