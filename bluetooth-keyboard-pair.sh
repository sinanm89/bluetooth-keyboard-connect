#! /bin/bash
address=$(cat /etc/bluetooth-keyboard-pairing/address)
while ( sleep 1 )
do
    connected=$(sudo hidd --show)
    if [[ ! $connected =~ ${address} ]]
    then
        hidd --connect $address
    fi
done
