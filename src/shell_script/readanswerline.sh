#!/bin/bash 
while read -n 1  onechar; do
        if test "$onechar" == '%'; then
                read -n 2 char1;
                if test "$char1" \> "7";then
                        read -n 1 char2
                        if test "$char2" == "%";then
                                read -n 2 char2
                                echo -n -e "\x$char1\x$char2";
                        else
                                echo -n -e "\x$char1$char2"
                        fi
                        continue;
                else
                        echo -n -e "\x$char1"
                fi
        else
                if test "$onechar" == '+';then
                        echo -n " "
                else
                        echo -n "$onechar"
                fi
        fi
done
exit 0
