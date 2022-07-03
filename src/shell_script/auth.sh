#!/bin/bash
. functions
. liuyaninit
declare returnuserid=""
read formvalue
if test  -n "$formvalue";then
        IFS='&'
        declare $formvalue
        username=`echo "$username" | sed -e "s/+//g"`
        IFS=$'  \r\n'
fi
if test "$username" == "";then
	echo -n $'\n'
	echo "用户名为空"
	echo '<input type="button" value="重新输入" onClick="history.go(-1)">'
        exit 0
else
        checkuser $username $password
        userid=$returnuserid
        if test $userid -eq -1;then
		echo -n $'\n'
                echo "用户名不存在或口令错误,请重新输入!"
		echo '<input type="button" value="重新输入" onClick="history.go(-1)">'
                exit 1
        else
                cookieuserid=$userid
                echo "Set-Cookie: cookieuserid=$cookieuserid; path=/"
		echo -n $'\n'
		echo "成功登录"
		echo '<meta http-equiv="refresh" content="0;URL=authok.sh">'
		echo '<a href=authok.sh>如果窗口没有自动刷新，请单击这里</a>'
                exit 0
        fi
fi
