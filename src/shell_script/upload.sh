#!/bin/bash
IFS=$' \t\r\n;'
echo -n $'Content-type: text/html'
echo -n $'\n\n'

echo '<html>'
#echo "<meta http-equiv=\"refresh\" content=\"0; url=ftp://lvren:woshilvren@$HTTP_HOST\">"
echo '照片上传的方法(于200702042035修改)   [修改]绿野无踪[2007/02/04星期天20:34]'
echo '<br>1.http://greenman.sdie.net/sshclient.exe下载并安装sftp,一路单击“下一步”即可。'
echo '<br>2.运行桌面上的“SSH Secure File Transfer Client”，单击“connect”按钮，host name为"greenman.sdie.net"或“202.194.254.211”,username和password分别lvren和woshilvren,后面一看就明白了。'

echo "</html>"
