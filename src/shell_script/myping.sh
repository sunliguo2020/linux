#!/bin/bash
#for nmap 4.65
max_rtt_timeout=200
if test ! -e ips;then
        echo "can not find file ips";
        exit
fi
#initialize serial port 
#stty -parenb -parodd cs8 hupcl -cstopb cread clocal -crtscts ignbrk -brkint -ignpar -parmrk -inpck -istrip -inlcr -igncr -icrnl -ixon -ixoff 
-iuclc -ixany -imaxbel -opost -olcuc -ocrnl -onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0 bs0 vt0 ff0 -isig -icanon -iexten -echo -echoe -e
chok -echonl -noflsh -xcase -tostop -echoprt -echoctl -echoke 9600 <$device;
while test 1 -eq 1;do
        echo -n `date +%y_%m-%d_%H:%M`;
        {
        while read oneip snmpcmd;do
                if test "$oneip" == "";then
                        continue;
                fi
                if test "${oneip:0:1}" == "#";then
                        comment="$oneip";
                        continue;
                fi
                i=$oneip;
                if test "$snmpcmd" != "";then
                        oldstr=`$snmpcmd`;
                        sleep 60s;
                        newstr=`$snmpcmd`;
                        if test "$oldstr" != "$newstr";then
                                continue;
                        else
                                echo -n " $i";
                        fi
                else
                        #nmap try 5 times,so total wait time can reach --max_rtt_timeout*5
                        /usr/local/bin/nmap -n -sP  --max_rtt_timeout $max_rtt_timeout $i >myping.temp;
                        if grep "${i} " "myping.temp" >/dev/null 2>/dev/null;then
                                continue;
                        else
                                /usr/local/bin/nmap -n -sP -PS --max_rtt_timeout $max_rtt_timeout $i >myping.temp;
                                if grep "${i} " "myping.temp" >/dev/null 2>/dev/null;then
                                        continue;
                                fi
                                echo -n " $i";
                        fi
                fi
        done
        }<ips
        echo;
        echo;
        sleep 30s;
done

