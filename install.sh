#!/bin/bash
echo 'Adding to startup items deleting old install if any...'
if [ -e /etc/bluetooth-keyboard-pair ]
    then
    sudo rm -rf /etc/bluetooth-keyboard-pair /etc/init.d/bluetooth-keyboard-startup
fi
sudo mkdir /etc/bluetooth-keyboard-pair
sudo cp ./bluetooth-keyboard-pair.sh /etc/bluetooth-keyboard-pair/keyboard.sh
sudo cp ./bluetooth-keyboard-startup /etc/init.d/bluetooth-keyboard-startup
chmod a+x /etc/bluetooth-keyboard-pair/keyboard.sh /etc/init.d/bluetooth-keyboard-startup
sudo update-rc.d -f bluetooth-keyboard-startup remove
sudo update-rc.d -f bluetooth-keyboard-startup defaults
echo 'Startup items added'
dialog --backtitle "Bluetooth Keyboard Pairing" --msgbox "Please turn on your keyboard to its pairing mode and press OK" 7 35
i=0
while [ $i -eq 0 ]
do
    command=$(hcitool scan)
    command2=${command//Scanning ...$'\n'/}
    if [ ${#command2} -gt 0 ]
    then
        i=1
    fi
done
command3=${command2//[ ]/-}
command4=${command3//[$'\t'$'\n']/ }
tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/bluetooth-keyboard-temp$$
trap "rm -f $tempfile" 0 1 2 5 15
dialog --backtitle "Bluetooth Keyboard Pairing" --menu 'Select keyboard' 0 0 0 $(echo $command4) 2> $tempfile
case $? in
  0)
    result=`cat $tempfile`
    sudo bash -c "echo $result > /etc/bluetooth-keyboard-pair/address"
    echo "/etc/bluetooth-keyboard-pair/address saved"
    sudo /etc/bluetooth-keyboard-pair/keyboard.sh &;;
  1)
    echo "Cancelled Pairing Process";;
  255)
    echo "Cancelled Pairing Process";;
esac
