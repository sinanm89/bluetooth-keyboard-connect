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
dialog --msgbox "Please turn on your keyboard to its pairing mode and press OK" 7 35
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
command5=(dialog --menu 'Select keyboard' 0 0 200 --stdout $(echo $command4))
result=$($command5)
sudo bash -c "echo $result > /etc/bluetooth-keyboard-pair/address"
echo "/etc/bluetooth-keyboard-pair/address saved"
sudo /etc/bluetooth-keyboard-pair/keyboard.sh &
