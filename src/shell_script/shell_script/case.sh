#/bin/bash

echo -n "enter a b c"
read ba


case $ba in

 a) echo "a";;
 b) echo "b";;
 c|C) echo "c C";;
 *) echo "***************" 
    echo $ba;;

esac

