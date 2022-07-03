#/bin/bash
#break
while : 
do 
    echo -n "Enter an  anmber[1-5]"
    read ans
    case $ans in
      1|2|34|5)
      echo "You enter a number between 1 to 5"
       ;;
      *)
        echo "Wrong !Bye !!"
      break;;
     esac
done 
