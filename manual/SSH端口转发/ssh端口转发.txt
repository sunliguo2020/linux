客户机：win10 192.168.10.149
树莓派：linux 192.168.10.71
阿里云主机：linux aliyun.sunliguo.com 外网
实验一：目的 客户机访问阿里云主机上的mysql服务。阿里云主机默认只放开22端口。
在树莓派上运行：
sunliguo@raspberrypi:~ $ ssh -L 1234:localhost:3306 -fN aliyun.sunliguo.com -g
sunliguo@raspberrypi:~ $ netstat -ntlp
(Not all processes could be identified, non-owned process info
 will not be shown, you would have to be root to see it all.)
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      -
tcp        0      0 127.0.0.1:50096         0.0.0.0:*               LISTEN      31240/ssh
tcp        0      0 127.0.0.1:50097         0.0.0.0:*               LISTEN      31239/autossh
tcp        0      0 0.0.0.0:1234            0.0.0.0:*               LISTEN      22061/ssh
tcp6       0      0 :::22                   :::*                    LISTEN      -
tcp6       0      0 ::1:50096               :::*                    LISTEN      31240/ssh
tcp6       0      0 :::1234                 :::*                    LISTEN      22061/ssh

现在在客户机上运行Navicat for mysql 连接 192.168.10.71 1234端口 就可以访问阿里云的mysql服务了。
下面两个命令和上面有什么不同？
sunliguo@raspberrypi:~ $ ssh -L 1234:aliyun.sunliguo.com:3306 -fN aliyun.sunliguo.com -g
sunliguo@raspberrypi:~ $ ssh -L 1234:127.0.0.1:3306 -fN aliyun.sunliguo.com -g
