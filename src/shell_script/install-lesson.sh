#!/bin/bash
. ./init
if test $# -ne 2; then
	echo "usage: $0 LESSONNAME FULLNAME"
	exit 1;
fi 
IFS=$'\t\n\r '
if [ ! -e manage/.htaccess ]; then
        echo 'AuthType basic' >manage/.htaccess
        echo "AuthName $1" >>manage/.htaccess
        echo "AuthUserFile `pwd`/passwd" >>manage/.htaccess
        echo "require valid-user" >>manage/.htaccess
        echo "Options ExecCGI"  >>manage/.htaccess
        chown $user:$group manage/.htaccess
        chmod 700  manage/.htaccess
fi
if [ ! -d $1 ]; then
        mkdir $1
        chown apache:apache $1
        chmod 755 $1
fi
if [ ! -d $1/quesresu ]; then
        mkdir $1/quesresu
        chown apache:apache $1/quesresu
        chmod 755 $1/quesresu
fi

if [ ! -d $1/quesresu/questions ]; then
	echo $1/quesresu/questions  
	mkdir $1/quesresu/questions 
	chown $user:$group $1/quesresu/questions 
	chmod 777 $1/quesresu/questions
fi
if [ ! -d $1/quesresu/results ]; then 
	echo $1/quesresu/results 
	mkdir $1/quesresu/results 
	chown $user:$group $1/quesresu/results 
	chmod 755 $1/quesresu/results
fi

if [ ! -d $1/quesresu/questions/picturesfile ]; then
        echo $1/quesresu/questions/picturesfile
        mkdir $1/quesresu/questions/picturesfile
        chown $user:$group $1/quesresu/questions/picturesfile
        chmod 777 $1/quesresu/questions/picturesfile
fi
if [ ! -d $1/quesresu/questions/shiyanbaogao ]; then
        echo $1/quesresu/questions/shiyanbaogao
        mkdir $1/quesresu/questions/shiyanbaogao
        chown $user:$group $1/quesresu/questions/shiyanbaogao
        chmod 777 $1/quesresu/questions/shiyanbaogao
fi
for (( i=5 ; i ; i=i-1 )); do
if [ ! -d $1/quesresu/questions/$i ]; then  
	echo $1/quesresu/questions/$i 
	mkdir $1/quesresu/questions/$i 
	chown $user:$group $1/quesresu/questions/$i 
	chmod 777 $1/quesresu/questions/$i
fi
done
if test ! -e lessons;then
	echo "">lessons
	chmod a+r lessons
fi
if ! cat lessons | grep '^$1 ';then
	echo "$1 $2" >>lessons
fi
echo "creating user $1 in /etc/passwd...."
/usr/sbin/adduser $1 -d `pwd`/$1/quesresu -g apache -s /sbin/nologin
passwd $1
if test ! $? -eq 0;then
	echo "create user $1 in /etc/passwd fail!"
	exit 1
fi
echo "creating user $1 in `pwd`/passwd"
htpasswd -c `pwd`/passwd $1
if test ! $? -eq 0;then
        echo "create user $1 in `pwd`/passwd fail!"
        exit 1
fi
chmod a+r `pwd`/passwd
