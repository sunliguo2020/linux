#/bin/bash
counter=0
echo "Enter your password"
 read trythis
while [ "$trythis" != "secret" ]; do
 echo "Sorry ,try again!"
 read trythis
done
echo "Hello!"
while [ "$counter" -ne 10 ] ;do
  echo $counter
  counter=$(($counter+1))
done

exit 0
