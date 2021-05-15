# Hardware

# Installing the OS
The Raspberry Pi Imager is used to install the operating system.
Start the app and select **Raspberry Pi OS Lite**.
Insert the sd card and select it, then press **Write*

When that is done, before ejecting the SD card, enable ssh and wifi.

## Enable ssh
Create an empty file named **ssh** in the boot partition of the SD card.

## Enable Wifi 
Create the file **wpa_supplicant.conf** in the same directory.
It should contain the following:


```
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=SE

network={
    ssid="NETWORK"
    psk="PASSWORD"
}
```

Change **NETWORK** and **PASSWORD**, and select country if other than Sweden.

Now eject the SD card and do this 4 times for each RPi.

# Running for first time
Start the RPi and try to ssh to it.
Default username is **pi**, password **raspberry**.
This will be changed.

Change to a static ip address for each node.
This will make it easier to ssh to the different nodes, and to run Ansible.

