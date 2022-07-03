#!/bin/bash
JUST_A_SECOND=1

funky()
{
	echo "This is a funky function"
	echo "Now exiting funky function"
}

fun ()
{
	i=0;
	REPEATS=30;

	echo 
	echo "And now the fun really begins"
	echo

	sleep $JUST_A_SECOND
	while [ $i -lt $REPEATS ]
	do
		echo "Functions ---"
		echo "<--are_-->"
		echo "===fun-=="
		echo 
		let "i+=1"
	done

}
	funky
	fun
	exit 0
