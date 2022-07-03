#!/bin/bash
#set -x
#判断改手机号是不是山东地区的
curl -s -d "mobile="$1"&action=mobile" http://www.ip138.com:8080/search.asp|\
iconv -f gb2312 -t utf-8|grep 山东 1>/dev/null 2>&1
if [ $? -eq 0 ];then

curl -s -d "menuid=netcharge&payphone="$1"&balance=+&accept_type=+&sum_fee=+&payphoneVal="$1"\
&repayphoneVal="$1"&bankname=ABC"  http://www.sd.chinamobile.com/ecare/bankpay.do?act=writePayInfo \
|iconv -f gbk -t utf-8|grep "[[:space:]][0-9]\{1,11\}[^a-z]" |grep -v "[a-z]"|sed 's/[^0-9 . ]//g'
	if [ $? -eq 0 ];then
		:
		#山东号，但是没有找到数据
	else
	echo "有错误发生"
	fi
else
	echo "$1 不是山东的手机号"
fi
