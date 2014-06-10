#! /bin/bash

address="00:1F:20:4D:7D:7E"
# Simple forloop counter which tries to connect for a minute
# It should connect within the first 10 seconds.
COUNTER=0
while [ $COUNTER -lt 20 ]
do
 let COUNTER=COUNTER+1
 connected="$(sudo hidd --show)"
# if theres bluetooth devices found and any match the address of your keyboard
 if [ -e "$connected" ] && [[ "$connected==$address" ]]
 then
  sudo hidd --connect $address
 fi
 sleep 3
done
