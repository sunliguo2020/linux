#!/bin/bash
#2015-02-05 cookie 存放在/tmp 目录下 mktemp
#2016-07-24 添加user_agent变量
COOKIE=`mktemp /tmp/cookie.XXXXXX` || exit 1

#存放数据的目录，默认在程序执行的当前目录下建立
#2015-03-16 改变保存文件的目录为17地市代码
#[ ! -d number ] && mkdir number

#登录函数
function denglu(){
#参数为登录名和密码
#登录用户名和密码,如果为空则设置默认值
if [ $1 ] && [  $2 ];then
    {
   	user=$1 
	passwd=$2
    } 
  else
      {
      user=15653613405
      passwd=000000
  }
fi
echo user=$user passwd=$passwd
user_agent="Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET4.0C; .NET4.0E; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)"
#登录前的一个参数
referer="http://218.56.65.202:9081/PB_INTERFACE/pgCusd_login_test/pgLogin_cusd.jsp" 
POST_USER="EOSOperator%2FuserID=$user&EOSOperator%2Fpassword=$passwd" 
USER_URL="http://218.56.65.202:9081//PB_INTERFACE/pgCusd_login_test/PB_COMMON.prCTGSLogin.login.do"

test2=`curl   -A "$user_agent" -e $referer -d $POST_USER $USER_URL  -c $COOKIE 2>/dev/null`
#test2=`curl  -A"$user_agent" -e $referer  $USER_URL  -c $COOKIE 2>/dev/null`
echo \$test2=$test2
#echo "$test"|grep "菜单"
#if [ "$?" = "0" ];then
#   echo "登录成功！！"
#  else
#    echo “密码错误或者是已经注销，重新登录!!”
#fi 
}