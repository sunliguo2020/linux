#/bash
echo -n "Enter your name:"
read name
if [ "$name" == "" ];then
     echo " you did not enter an infomation"
else
    echo "your name is $name"
fi
if test -x iftest.sh ; then
    echo iftest.sh is a file
else
    echo iftest.sh is not a file
fi
