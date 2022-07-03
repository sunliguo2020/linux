#!/bin/bash
echo $1
curl -s -d "ip=$1&action=2" http://www.ip138.com/ips.asp|iconv -f gb2312 -t utf-8|grep 'ul class="ul1"'|sed -e 's/^.*"><li>/\t/' -e 's/<\/li><li>/\n\t/g' -e 's/<.*$//'
