#!/bin/bash
function upperchar
{
	uppers=(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)
	lowers=(a b c d e f g h i j k l m n o p q r s t u v w x y z)
	for (( i=0 ; 26-i ; i=i+1 ));do
		if test "$1" == ${lowers[i]};then
			echo -n ${uppers[i]}
			return
		fi
	done
	echo -n $1
}
if test ! $# -eq 1;then
	echo "usage: $0 RESULTDIR"
	exit 1
fi
dirs=`ls -d $1/*`
for i in $dirs;do
	scoreselection=0
	scoreyesorno=0
	if test ! -e "$i/stuinfo"; then 
		continue
	fi
	declare `cat "$i/stuinfo"`
	IFS='/'
	dirnames=($i)
	index=${#dirnames[*]}
	index=$((index-1))
	echo -n "${dirnames[index]} "
	IFS=$' 	\r\n' 
	echo -n $stuname | ./readanswerline.sh	
	if test -e "$i/correctselections" -a -e "$i/stuselections";then
		unset correctselections
		unset stuselections
		line=0
		{ while read  oneline;do
			correctselections[$line]=$oneline
			line=$(($line+1))
		done
		} <$i/correctselections
		line=0;
		{ while read  oneline;do
			stuselections[$line]=$oneline
			line=$(($line+1))
		done
		} <$i/stuselections
		for (( j=${#correctselections[*]}-1 ; j+1; j=j-1 )); do
			correctselect=${correctselections[$j]};
			correctselect=${correctselect:0:1}
			stuselect=${stuselections[$j]};
			stuselect=${stuselect:0:1}
			if test "$stuselect" == "`upperchar $correctselect`" ;then
				scoreselection=$((scoreselection+1))
			fi		
		done
	fi
        if test -e "$i/correctyesornos" -a -e "$i/stuyesornos";then
                unset correctselections
                unset stuselections
                line=0
                { while read  oneline;do
                        correctselections[$line]=$oneline
                        line=$(($line+1))
                done
                } <$i/correctyesornos
                line=0;
                { while read  oneline;do
                        stuselections[$line]=$oneline
                        line=$(($line+1))
                done
                } <$i/stuyesornos
                for (( j=${#correctselections[*]}-1 ; j+1; j=j-1 )); do
                        correctselect=${correctselections[$j]};
                        correctselect=${correctselect:0:1}
                        stuselect=${stuselections[$j]};
                        stuselect=${stuselect:0:1}
                        if test "$stuselect" == "`upperchar $correctselect`" ;then
                                scoreyesorno=$((scoreyesorno+1))
                        fi
                done
	fi
	echo  " $scoreselection $scoreyesorno $stuphone <br>"
done
