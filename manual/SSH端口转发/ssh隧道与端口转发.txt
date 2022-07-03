SSH/plink命令的基本资料：
首先，认识下这三个非常强大的命令：
ssh -C -f -N -g -L listen_port:DST_Host:DST_port user@Tunnel_Host 
ssh -C -f -N -g -R listen_port:DST_Host:DST_port user@Tunnel_Host 
ssh -C -f -N -g -D listen_port user@Tunnel_Host
相关参数的解释： 
-f Fork into background after authentication. 
后台认证用户/密码，通常和-N连用，不用登录到远程主机。
-L port:host:hostport 
将本地机(客户机)的某个端口转发到远端指定机器的指定端口. 工作原理是这样的, 本地机器上分配了一个 socket 侦听 port 端口, 一旦这个端口上有了连接, 该连接就经过安全通道转发出去, 同时远程主机和 host 的 hostport 端口建立连接. 可以在配置文件中指定端口的转发. 只有 root 才能转发特权端口. IPv6 地址用另一种格式说明: port/host/hostport
-R port:host:hostport 
将远程主机(服务器)的某个端口转发到本地端指定机器的指定端口. 工作原理是这样的, 远程主机上分配了一个 socket 侦听 port 端口, 一旦这个端口上有了连接, 该连接就经过安全通道转向出去, 同时本地主机和 host 的 hostport 端口建立连接. 可以在配置文件中指定端口的转发. 只有用 root 登录远程主机才能转发特权端口. IPv6 地址用另一种格式说明: port/host/hostport
-D port 
指定一个本地机器 “动态的’’ 应用程序端口转发. 工作原理是这样的, 本地机器上分配了一个 socket 侦听 port 端口, 一旦这个端口上有了连接, 该连接就经过安全通道转发出去, 根据应用程序的协议可以判断出远程主机将和哪里连接. 目前支持 SOCKS4 协议, 将充当 SOCKS4 服务器. 只有 root 才能转发特权端口. 可以在配置文件中指定动态端口的转发.
-C Enable compression. 
压缩数据传输。
-N Do not execute a shell or command. 
不执行脚本或命令，通常与-f连用。
-g Allow remote hosts to connect to forwarded ports. 
在-L/-R/-D参数中，允许远程主机连接到建立的转发的端口，如果不加这个参数，只允许本地主机建立连接。注：这个参数我在实践中似乎始终不起作用。

先给出本文主角，两条SSH命令：
远程端口转发（由远程服务器某个端口转发到本地内网服务器端口）

ssh   -CfNg  -R(命令行的关键)   2222(远程服务器端口)：127.0.0.1:22(本地端口)   123.45.67.8(远程服务器) 
本地端口转发（由本地内网服务器某个端口转发到远程服务器端口）

ssh   -CfNg  -L(命令行的关键)    2222(远程服务器端口):0.0.0.0:4444(本地端口)   123.45.67.8(远程服务器) 
命令行选项解释：
-C：压缩数据传输。
-f ：后台认证用户/密码，通常和-N连用，不用登录到远程主机。
-N ：不执行脚本或命令，通常与-f连用。
-g ：在-L/-R/-D参数中，允许远程主机连接到建立的转发的端口，如果不加这个参数，只允许本地主机建立连接。
-L 本地端口:目标IP:目标端口
-T 不分配 TTY 只做代理用
-q 安静模式，不输出 错误/警告 信息


需要让远程机器能访问的内部机器的端口号(端口:22)
在清楚了上面的参数后，我们使用下面的命令来建立一个远程SSH隧道,在内网主机执行

ssh   -CfNg -R 2222:127.0.0.1:22  123.45.67.8
现在，在IP是123.45.67.8的机器上我们用下面的命令就可以登陆内网IP为192.168.0.100的机器了。

ssh -p 2222 localhost
现在公网ip的 123.45.67.8 主机可以本地访问内网服务端了,那内网客户端要怎么登陆呢？，我们只需要把内网客户端的 4444 端口映射到 123.45.67.8 的 2222端口即可。

现在我们需要本地转发了。

ssh  -CfNg   -L  2222:0.0.0.0:4444   123.45.67.8
执行完后，本地的内网客户端 4444 端口已经和 123.45.67.8 的 2222 端口连接起来，然后 123.45.67.8 的 2222 端口 又和 内网服务端的 22 端口连接起来，成为一个完整的映射链。


内网服务器运行：
sunliguo@raspberrypi:~ $ ssh -CfNg -R 2222:127.0.0.1:22 root@aliyun.sunliguo.com
sunliguo@raspberrypi:~ $ netstat -ntp
(Not all processes could be identified, non-owned process info
 will not be shown, you would have to be root to see it all.)
Active Internet connections (w/o servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 192.168.10.71:47298     39.106.198.59:22        ESTABLISHED 15439/ssh
公网服务器：
[root@aliyun ~]# netstat -nltp
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address               Foreign Address             State       PID/Program name
tcp        0      0 127.0.0.1:2222              0.0.0.0:*                   LISTEN      25447/sshd
tcp        0      0 0.0.0.0:22                  0.0.0.0:*                   LISTEN      920/sshd
[root@aliyun ~]#
