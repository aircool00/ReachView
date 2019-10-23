#!/bin/bash

echo "Installing new packages"
apt-get update
#apt-get install kernel-module-ftdi-sio
pip install pybluez

echo "Reconfigure bluetoothd"
/home/pi/ReachView/reach_tools/bluetoothd.py

echo "Restart bluetoothd"
systemctl daemon-reload
systemctl restart bluetooth.service
hciconfig hci0 reset
