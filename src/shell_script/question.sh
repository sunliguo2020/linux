#!/bin/bash
. ./init
chnumber=(零 一 二 三 四 五 六 七 八 九 十)
read formvalue
if test ! "$formvalue" == "";then
	IFS='&'
	declare $formvalue
	IFS=$' 	\r\n'
fi
echo -n $'Content-type: text/html\n'
echo -n $'\n'
echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=gb2312">'
echo '</head>'
echo '<body>'
operation=login
if test "$trueno" == "";then
#not login or relogin
	if test -n "$hiddenno";then
		trueno=$hiddenno
		truesubject=$hiddensubject
	        {
                while read lessonname lessonfullname;do
                        if test "$lessonname" == "$truesubject";then
                                truesubject1="`echo $lessonfullname | ./readanswerline.sh`"
                                break;
                        fi
                done
                } <lessons
		if test -n "$save";then
			operation=save
		else
			operation=submit
		fi
	else
		echo 'No. can not be empty!'
		exit 1;
	fi
else
#login or relogin
	if test "$truesubject" == "";then
		echo "<br>please select subject!"
		exit 1
	fi
	echo "$trueno" | grep "^[0123456789]*$" >/dev/null;
	if test ! $? -eq 0;then
		echo '<br>please correctly input No.!'
		exit 1
	fi 
	if test ! -n "$truename";then
		echo 'name can not be empty!'
		exit 1
	fi
	{
	while read lessonname lessonfullname;do
		truesubject1="`echo $truesubject | ./readanswerline.sh`"
       		if test "$lessonfullname" == "$truesubject1";then
               		truesubject=$lessonname;
               		break;
       		fi
	done
	} <lessons
fi
if [ -e $truesubject/option ]; then
	. $truesubject/option
fi
if [ -e $truesubject/quesresu/results/$trueno/stuinfo ]; then
	. $truesubject/quesresu/results/$trueno/stuinfo
fi
if test "$finished" == "1";then
	echo "can only submit once!"
	exit 1
fi
echo -n "$trueno "
if test -n "$truename";then
	echo -n "$truename" | ./readanswerline.sh
else
	echo -n "$stuname" | ./readanswerline.sh
fi
echo -n " $truesubject1"
if test ! -e $truesubject/randlibold; then
	echo -n "" >$truesubject/randlibold
fi
if test "$operation" == "login";then
	if test -n "$lastrand";then
		if test ! "$lastrand" == "$rand";then
			echo '<br>please input a correct rand!'
			exit 1
		fi
	else
		cat $truesubject/randlib | grep ^$rand$ >/dev/null
		if test ! $? -eq 0;then
			echo '<br>rand does not exist!'
			exit 1
		else
			cat $truesubject/randlibold | grep ^$rand$ >/dev/null
			if test ! $? -eq 0;then
				echo "$rand">>$truesubject/randlibold
			else
				echo "<br>rand used by other!"
				exit 1
			fi
		fi
	fi
	if [ ! -e $truesubject/quesresu/results/$trueno ]; then
		mkdir $truesubject/quesresu/results/$trueno
		if test ! $? -eq 0;then
			echo "can not create dir $truesubject/quesresu/results/$trueno!"
			exit 1;
		fi
	fi
	if test ! -e $truesubject/quesresu/results/$trueno/stuinfo;then
		echo -n "" >$truesubject/quesresu/results/$trueno/stuinfo
	fi
	echo "remoteip=$REMOTE_ADDR" >$truesubject/quesresu/results/$trueno/stuinfo
	echo "lastrand=$rand" >>$truesubject/quesresu/results/$trueno/stuinfo
	echo "stuname=$truename" >>$truesubject/quesresu/results/$trueno/stuinfo
	echo "stuphone=$truephone" >>$truesubject/quesresu/results/$trueno/stuinfo
	if test ! -e $truesubject/quesresu/results/$trueno/questions.txt;then
		declare questions_not_exist=0;
	fi
fi
for (( typeindex=$testtypes ; typeindex ;typeindex=$typeindex-1 ));do
	varname=attrib$typeindex
	if test "${!varname}" == ""; then
		declare $varname=other
	fi
	varname=count$typeindex
        if test "${!varname}" == ""; then
                declare $varname=1
        fi
done
if test "$operation" == "login";then
for (( typeindex=1 ; $testtypes-$typeindex+1 ; typeindex=$typeindex+1 )); do
	attribvarname=attrib$typeindex
	countvarname=count$typeindex
	filecount=(`ls $truesubject/quesresu/questions/$typeindex | wc`)
	. random.sh ${filecount[0]} ${!countvarname}
	if test ! $? -eq 0; then
		echo 'random.sh fail!'
		exit 1;
	fi
	if test -n "$questions_not_exist";then
		if test "${!attribvarname}" == "selection";then
			questiontypestr="选择题"
			correctfilename=correctselections
		fi
		if test "${!attribvarname}" == "yesorno";then
			questiontypestr="判断题"
			correctfilename=correctyesornos
		fi
		test "${!attribvarname}" == "other"&&questiontypestr="其它"
		echo -------------------------------- 第${chnumber[$typeindex]}题\($questiontypestr\) ------------------------  >>$truesubject/quesresu/results/$trueno/questions.txt
		filenames=(`ls $truesubject/quesresu/questions/$typeindex`)
		for (( i=${#randoms[*]} ; i ; i=i-1 )); do
			if test -n "$questions_not_exist";then
				test ! "${!attribvarname}" == "other"&&echo $((${#randoms[*]}-i+1)). >>$truesubject/quesresu/results/$trueno/questions.txt
				if test "${!attribvarname}" == "selection" -o "${!attribvarname}" == "yesorno";then
					{ read  correctselection
					echo $correctselection >>$truesubject/quesresu/results/$trueno/$correctfilename
					while read oneline;do
						echo $oneline >>$truesubject/quesresu/results/$trueno/questions.txt
						oneline=""
					done
					echo $oneline >>$truesubject/quesresu/results/$trueno/questions.txt
					}< $truesubject/quesresu/questions/$typeindex/${filenames[${randoms[i-1]}]}
				else
					cat $truesubject/quesresu/questions/$typeindex/${filenames[${randoms[i-1]}]} >>$truesubject/quesresu/results/$trueno/questions.txt
				fi
				echo
			fi
		done
	fi

done
if test -e $truesubject/quesresu/results/$trueno/stuselections;then
	{ i=1;
	while read oneline;do
		declare select$i=$oneline
		i=$((i+1))
	done
	}< $truesubject/quesresu/results/$trueno/stuselections
fi
if test -e $truesubject/quesresu/results/$trueno/stuyesornos;then
	{ i=1;
	while read oneline;do
		declare yesorno$i=$oneline
		i=$((i+1))
	done
	}< $truesubject/quesresu/results/$trueno/stuyesornos	
fi
fi
echo '&nbsp&nbsp'
if test "$operation" != "submit";then
	echo "<a href=readquestions.sh?subject=$truesubject&stuno=$trueno target=_blank>单击此处在新窗口中打开试题</a>"
	if test -d "$truesubject/quesresu/questions/picturesfile" -o -d "$truesubject/quesresu/questions/shiyanbaogao";then
		picfiles=`ls $truesubject/quesresu/questions/picturesfile`
		for i in $picfiles;do
			echo "<a href=$truesubject/quesresu/questions/picturesfile/$i target=_blank>单击此处打开图片文件</a>"
		done
		shiyanbaogaofiles=`ls $truesubject/quesresu/questions/shiyanbaogao`
		for i in $shiyanbaogaofiles;do
			echo "<a href=$truesubject/quesresu/questions/shiyanbaogao/$i target=_blank>单击此处打开实验报告</a>"
		done
		echo "<br>"
	fi
else
	echo "<font color="#FF000">考试结束，答案保存成功!请关闭本窗口和试题窗口离开考场！</font>"
fi
echo '<form action=question.sh method=POST>'
echo "<input type=hidden name=hiddensubject value=$truesubject>"
echo "<input type=hidden name=hiddenno value=$trueno>"
if test ! "$operation" == "login";then
	echo -n "" >$truesubject/quesresu/results/$trueno/stuselections
	echo -n "" >$truesubject/quesresu/results/$trueno/stuyesornos
fi
for (( typeindex=1 ; $testtypes-$typeindex+1 ; typeindex=$typeindex+1 )); do
	attribvarname=attrib$typeindex
	countvarname=count$typeindex
	count=${!countvarname};
	if test "${!attribvarname}" == "selection";then
		stufilename=stuselections
		formselectprefix=select
	fi
	if test "${!attribvarname}" == "yesorno";then
		stufilename=stuyesornos
		formselectprefix=yesorno
	fi
	if test "${!attribvarname}" == "selection" -o "${!attribvarname}" == "yesorno";then
		echo "<br>-------------------------------- 第${chnumber[$typeindex]}题答题区 ------------------------<br>"
		for (( i=$count ; i ; i=i-1 ));do
			if test $((($count-i+1)%5)) -eq 1;then
				if test $(($count-i+1)) -lt 10;then
					echo -n "&nbsp"
				fi
				echo "$(($count-i+1))."
			fi
			tempname=$formselectprefix$(($count-i+1))
			if test ! "$operation" == "login";then
				echo "${!tempname}" >>$truesubject/quesresu/results/$trueno/$stufilename
			fi
			tempname1=selected${!tempname}
			declare ${tempname1}=selected
			if test "${!attribvarname}" == "selection";then
				echo "<select name=select$(($count-i+1))><option $selected><option $selectedA>A<option $selectedB>B<option $selectedC>C<option $selectedD>D</select>"
			else
				echo "<select name=yesorno$(($count-i+1))><option $selected><option $selectedY>Y<option $selectedN>N</select>"	
			fi
			unset ${tempname1}
			if test $((($count-i+1)%5)) -eq 0;then
				echo '&nbsp'
			fi
			if test $((($count-i+1)%10)) -eq 0;then
				echo '<br>'
			fi
		done
	fi
	if test "${!attribvarname}" == "other";then
		if test ! "$operation" == "login";then
			echo "$answer" >$truesubject/quesresu/results/$trueno/others 
		fi
		echo '<br>-------------------------------- 其它题目答题区-----------------------'
		if test -e $truesubject/quesresu/results/$trueno/others;then
			echo "<p><textarea rows=\"25\" name=\"answer\" cols=\"100\">"
			cat $truesubject/quesresu/results/$trueno/others | ./readanswerline.sh
			echo "</textarea></p>"
		else
			echo "<p><textarea rows=\"25\" name=\"answer\" cols=\"100\"></textarea></p>"
		fi
	fi	

done
if test "$operation" == "submit";then
	echo 'finished=1' >> $truesubject/quesresu/results/$trueno/stuinfo	
else
	echo '<input type="submit" value="暂存(以防掉电丢失!)" name="save">'
	echo '&nbsp;&nbsp;'
	echo '<input type="submit" value="提交" name="submit">'
	echo '<font color="#FF000">答题完毕必须提交！</font>'
fi
echo '</body>'
echo '</html>'	
