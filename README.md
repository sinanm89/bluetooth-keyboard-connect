Bluetooth-Keyboard-Connect
==========================

Connect your keyboard (in my case a logitech K810) to your computer everytime your computer starts. This is a method to be used if when you change OS's often and find that the keyboard has to be re-paired everytime and the pairing process is as cumbersome as the K810.

Installation
------------

You should first make sure hidd is installed. Its deprecated but worked best for me. I then checked it with blueman because the default bluetooth manager did not help me at all.

    sudo apt-get install bluez-compat blueman
    
Now place the files as `/etc/keyboard.sh` and `/etc/init.d/keyboard` and make them executable.

    sudo chmod +x /etc/init.d/keyboard /etc/keyboard.sh

If you want to connect manually then just;

    sudo /etc/keyboard.sh

Thats it. Next time you reboot you should be able to connect the keyboard if the keyboard is in pairing mode.
