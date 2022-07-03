1:echo $SHELL
cat /ect/shells
2:上下箭头 TAB键 help
3:存取权限与安全 -rwxr--r--
setuid(suid/guid) (chmod u+s file)
chmod umask chgrp chown umask
4:shell 脚本基本元素
第一行 : #!/bin/bash
#注释 变量
5:jobs -l
管道 ls |sort
重定向sort <myfile.txt
sort <myfile.txt >myfile_sort.txt
模式匹配:ls -l *txt
特殊字符：
双引号("") 单引号 ('') 反引号(``)反斜杠(\) ; & () {} | <> ?[] $ #
Chap 2
变量 :
本地变量: variable-name=value set 显示本地所有的变量
   readonly variable-name
   环境变量 export env $HOME/.bash_profile
   /etc/profile
   变量替换 echo $var
            echo ${var}
   unset 
   $0 $1 --- $9
   标准变量：/etc/profile
    EXINIT HOME IFS LOGNAME MAIL MAILCHECK 
   
for loop in `cat file`
do 
  echo $loop
done
