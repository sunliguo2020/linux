; 命令分隔符，可以用来在一行中写多个命令
;; 终止 “case” 选项
: 空命令
！取反操作
*
$
${}
$* 
$@
$? 退出状态变量
$$ 变量ID

$- 使用set及执行时传递给shell的标志位
$! 最后一个子进程的进程号
$# 传递给shell script的参数个数
$* 传递给shell script的参数
$@ 所有参数个别的用双引号括起来
$ 上一个命令的返回代码
$0 当前shell的名字
$n (n:1-) 位置参数
$$ 进程标识号(Process Identifier Number, PID) 


() 命令组 在()中的命令列表，将作为一个子shel来运行
(a=hello;echo $a)
{} 代码块 不会开启一个新shell
{}\； 路径名 一般在结束find命令中使用。
[]  test 

scriptname > filename 
command &>filename   重定向stdout和stderr到文件
command >&2 重定向command的stdout到stderr
|| 或逻辑操作


比较操作：
整数比较
-eq
-ne
-gt
-ge
-lt
-le
<
<=
>
>=

字符串比较
=
==


-z 字符串为“null”，就是长度为0
-n 字符串不为"null"

if [] ;then
else
fi

for loop in `cat file`
do 
	echo $loop
done

数组
service=（httpddown mail）
echo ${service[1]}
echo ${service[*]}

expr 4 + 5  注意空格
echo $((4+5))
echo $(date)

