#!/bin/bash
echo -n $'Content-type: text/html\n'
echo -n $'\n'
echo "<html> <head> <meta http-equiv=\"Content-Type\" content=\"text/html; charset=gb2312\"> </head> <body> 选择考试科目: <form action=question.sh method=POST> <input type=hidden name=hiddensubject value=\"0\"> <input type=hidden name=hiddenno value=\"0\"> <input type=hidden name=hiddennextquestion value=\"0\"> <select name=\"truesubject\">"
{
while read lessonname lessonfullname;do
	echo "  <option>${lessonfullname}"
done
} <lessons
echo " </select><p> 验证码:<input type=text name=rand><p> 姓名:<input type=text name=\"truename\" ><p> 学号:<input type=text name=\"trueno\"><p> 电话(必填,能找着你的就行):<input type=text name=\"truephone\"><p> <input type=submit value=\"ok\">(请确认准确无误再ok) </form> </body> </html>"

