# Hardware
The heart of the cluster is the four Raspberry Pi 4 Model B.
Went with the larger memory configuration just because.
More is always better right!?

The RPi has an official power adapter, but did not want to have so many charging cables.
So went with a USB hub power supply, the Anker PowerPort seems to be a good choice when checking the forums.

A switch, the Pis will use that when communicating with each other instead of over Wi-Fi.

List of hardware:

- 4 x Raspberry Pi 4 Model B 8GB
- SanDisk 32 GB Extreme Pro MikroSDHC
- Anker PowerPort 6
- 4 x USB cables, 25cm
- D-Link DGS-105 5-ports Switch
- 4 x Ethernet cables
- stackable cluster case with heatsinks and fans.

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
See router documentation on how to do that.

Change the hostname of each RPi.
Every RPi will use the same name by default, this can be a bit confusing.
So change it by editing the file:

`sudo nano /etc/hosts`

Change this line:

`127.0.1.1		raspberrypi`

To:

`127.0.1.1		UNIQUE_NAME`

Where **UNIQUE_NAME** is the new name of the RPi.
Then edit this file:

`sudo nano /etc/hostname`

Change the line:

`raspberrypi`

To:

`UNIQUE_NAME`

The name should be the same in both of the files, but different on the different RPis.

Finally, reboot:

`sudo reboot`

Might add this as Ansible tasks as well. 

# Shutting down the cluster

ssh to each node and run:

`sudo shutdown -h now`

Doing this every time might be annoying, so better is either to create a script, do it with Ansible or create a physical shut dow button.
Or a combination of the above