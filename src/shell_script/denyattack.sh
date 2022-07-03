#!/bin/bash
sleeptimes=0;
while test 0 -eq 0;do
	sleep 3;
	sleeptimes=$((sleeptimes+1));
	#deny quick ssh connection*****
	ips=(`tail /var/log/secure  -n 5| grep 'Illegal user\|Failed password'|sed 's/.*from \(\<[0123456789.]*\).*/\1/g'`);
	count=${#ips[*]};
	if test ! $count -lt 3;then
		flag=1;
		for (( i=$count ; i-1 ; i=$i-1 ));do
			if test "${ips[i-1]}" != "${ips[i-2]}";then
				flag=0;
				break;
			fi
		done
		if test $flag -eq 1;then
			iptables -L -n | grep "${ips[0]}" >/dev/null
			if test ! $? -eq 0;then
				iptables -A INPUT -s ${ips[0]} -j DROP;
			fi
		fi
	fi		
	#deny quick ssh connection end*****

	#deny HTTP Q request*****
	tail /var/log/httpd/access-lvren-log -n 20 | grep -v '"GET' | grep -v '"POST' | grep -v '"HEAD' | grep -v '"OPTIONS' |cut -d ' ' -f 1 | while read oneip;do if iptables -n -L | grep "$oneip" >/dev/null 2>/dev/null;then continue;else iptables -A INPUT -s $oneip -j DROP;fi;done
	#deny HTTP Q request end*****
	
	#flush iptables INPUT chain every 3600s*****
	if test $sleeptimes -gt 1200;then
		sleeptimes=0;
		iptables -F INPUT;
	fi
	#flush iptables INPUT chain every 3600s end*****
done
