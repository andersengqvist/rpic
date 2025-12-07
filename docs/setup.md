# Conventions
All file and directory paths are from the root of the project.
So the file `hello.txt` is located in the root directory, not in the `docs/` where this document is located.

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
Change the password.

# Change hostname
Change to a static ip address for each node.
This will make it easier to ssh to the different nodes, and to run Ansible.
Log in to the router and assign a static ip to each rpi.
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

This is the table of the host names and static ip addresses:

| Hostname | IP           |
| -------- |------------- |
| rpic01   | 192.168.1.21 |
| rpic02   | 192.168.1.22 |
| rpic03   | 192.168.1.23 |
| rpic04   | 192.168.1.24 |

# Setup ssh keys
Ssh keys make it possible to ssh to a cluster node without having to provide password.
Ssh keys will also make it easier with Ansible.
Generate the keys with this command:

`ssh-keygen -t rsa -b 2048 -f ~/.ssh/rpic_key`

Then copy the public key to each host with this command:

`ssh-copy-id -i ~/.ssh/rpic_key pi@HOST`

Test:

`ssh -i ~/.ssh/rpic_key pi@HOST`

# Shutting down the cluster

ssh to each node and run:

`sudo shutdown -h now`

Or, run this script to shut down all nodes:

`./shutdown_rpic.sh`

Maybe investigate creating a physical shut dow button.
Looks like it is possible to both shut down and wake up using the gpios.

# Commands

## Reboot
`sudo reboot`

## Shut down
`sudo shutdown -h now`

# Links
Inspirational links:

https://hackernoon.com/building-cheap-raspberry-pi-cluster-from-scratch-uf1f3u7z
The github repo https://github.com/ikaruswill/cluster-ansible-roles

https://magpi.raspberrypi.org/articles/build-a-raspberry-pi-cluster-computer

https://dev.to/shandesai/provision-your-raspberry-pi-4-cluster-with-ansible-2j8m

https://github.com/aapit/ansible-k3s-rpi
