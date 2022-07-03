awk [-F filed-spearator] 'command' input-files
awk -f awk-script-file input-file

模式 
动作 {print }

分割符 域 记录
$1 $2 $3 --- $n $0 所有域

awk '{print $0}' score.txt|sort score.out
awk '{print $0"\t"}' score.txt|sort score.out
+  任意字符
? 一个字符
~ 匹配
!~ 不匹配
cat score.txt|awk '$0 ~ /202.194.240.65/'
awk '{if($1=="202.194.246.65") print $0}' score.txt


