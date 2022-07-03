if ! test $# -eq 2;then
	echo "USAGE random.sh DOMAIN COUNT!"
	return 1
fi
if test $2 -gt $1; then
	echo "COUNT $2 can not greater than DOMAIN $1!"
	return 1
fi
unset randoms
declare randoms[$2]
i=0
#RANDOM=`date +%s`
#RANDOM=$((${RANDOM}%32768))
for (( ;  ; )); do
	if test $i -eq $2; then
		break;
	fi
	random=$((${RANDOM}%$1))
	for (( j=$i ; j ; j=j-1 )); do
		if test ${randoms[$j-1]} -eq $random; then
			break;
		fi
	done
	if test ! $j -eq 0; then
			continue
	fi
	randoms[$i]=$random
	i=$((i+1))
done
#for (( j=$2; j ; j=j-1 )); do
#	echo ${randoms[$j-1]}
#done
return 0
