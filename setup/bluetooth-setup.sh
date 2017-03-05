#!/bin/bash

# Set main.conf to disable Bluetooth-LE for pairing (https://goo.gl/MxQYG0)
sudo mv /etc/bluetooth/main.conf /etc/bluetooth/main.conf.bkp
sudo printf '[General]\nControllerMode = bredr\n' | sudo tee -a /etc/bluetooth/main.conf > /dev/null
sudo service bluetooth restart

# Wait for user to pair headphones
read -p "Pair all headphones as necessary, then press enter"

# Reset main.conf to re-enable Bluetooth-LE
sudo rm /etc/bluetooth/main.conf
sudo mv /etc/bluetooth/main.conf.bkp /etc/bluetooth/main.conf

# Disable HSP/HSF mode; force A2DP
sudo printf "[General]\nDisable=Socket\nDisable=Headset\nEnable=Media,Source,Sink,Gateway\nAutoConnect=true\nload-module module-switch-on-connect\n" | sudo tee /etc/bluetooth/audio.conf > /dev/null

sudo service bluetooth restart
printf "\e[1;93mNOTE: You may need to update ~/bin/a2dpWatcher.py to correct the MAC addresses in DEV_IDS for the headphones you are using.\n\e[m"
