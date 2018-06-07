# Introduction
This fork contains a series of simple c routines that demonstrate how to program the QUIMAT  basic resistive touchscreen. Two of the programs have come from the [original Github repo](https://github.com/mwilliams03/Pi-Touchscreen-basic) and another one has been copied from [another fork by Lalks](https://github.com/Lalks/Pi-Touchscreen-basic)
 
This fork of the original has been tested with my old Raspberry Pi model B+ running Raspbian Stretch and I connected it to the cheapish £20 Quimat 3.5 inch touch screen.  I suspect that although Quimat no longer have this for sale, other suppliers are probably selling the identical hardware.  The first attempts to get the touchscreen to run were a struggle so see my getting started tips at the end of this README and save yourself a bit of time to get going.  I also added a makefile to simplify the building of the binaries.

I have supplied the following 3 demonstration programs:

* draw - a simple touch screen drawing program
* LKSdemo - two on-screen buttons, on containing toggling text
* buttontest - 3 coloured buttons that can be used to toggle the GPIO outputs
# Building and testing the example programs
** IMPORTANT unplug all connections to the RPi USB ports before using these test program**  Leaving a mouse or keyboard plugged in will cause these test programs to pick up a keyboard or mouse instead of the touch screen as input and they will not work correctly.

To build all 3 test programs connect to the RPi via SSH and navigate to your clone of this repo and just run
>make

If all is well you should see just 2 warning messages displayed as the makefile builds all 3 test programs.  You can now run each in turn.  As each program starts you will see the following message on your SSH connection.

>Input device name: "ADS7846 Touchscreen"  
Supported events:  
  Event type 0 (Sync)  
  Event type 1 (Key)  
    Event code 330 (Touch)  
  Event type 3 (Absolute)  
    Event code 0 (X)  
     Value      0  
     Min        0  
     Max     4095  
    Event code 1 (Y)  
     Value      0  
     Min        0  
     Max     4095  
    Event code 24 (Pressure)  
     Value      0  
     Min        0  
     Max      255  
Original 480x320, 16bpp  
Framebuffer /dev/fb1 resolution;  
480x320, 16 bpp  
X Scale Factor = 8.531250  
Y Scale Factor = 12.796875  

To run each program from the cloned repo directory enter on the command line either ./draw  ./LKSdemo or ./buttontest  
As you touch the screen with the stylus the SSH connection will display a stream of stylus position information and the displayed buttons will respond when they are pressed or in the case of the draw program you can draw a picture on the touch screen.

I found that the original version of buttontest caused the screen display to go white and the only way to recover it was to reboot the RPi.  It seems that this was caused by changing the state of GPIO 6.  For some reason the touchscreen needed this pin to be left in a 1 state!

# Getting started
## Installing Raspian
I downloaded Raspbian Stretch with desktop and installed it on an SD card .  
Version: April 2018  
Release date: 2018-04-18  
Kernel version: 4.14  
but hopefully future Raspbian versions will also work too.

## Setting up headless operation
I then set up the RPi to allow headless operation via SSH and set it to use a fixed IP address on my network. Both of these can be done by editing the SD card before installing it in the RPi for the first time. 

For headless setup, SSH can be enabled by placing a file named ssh, without any extension, onto the boot partition of the SD card from another computer. When the Pi boots, it looks for the ssh file. If it is found, SSH is enabled and the file is deleted. The content of the file does not matter; it could contain text, or nothing at all.  If you have loaded Raspbian onto a blank SD card, you will have two partitions. The first one, which is the smaller one, is the boot partition. Place the file into this one.

Now edit  /etc/dhcpcd.conf to add (change the IP addresses to suit your home router)

>interface eth0  
profile static_eth0  
static ip_address=192.168.1.200  
static routers=192.168.1.1  
static domain_name_servers=192.168.1.1  

Connect the RPi using an ethernet cable to your router. You should now be able to boot the RPi without a display and make an SSH connection to it immediately.  You can now complete the installation of the display driver.

## Installing the LCD driver
Clone the [display driver repo](https://github.com/goodtft/LCD-show) to your RPi and follow the installation instructions in its readme file. 

Before installing the touch screen I found it necessary to disable the graphical desktop.  This seems unable to drive the LCD screen (the screen just goes white) so use raspi-config to set auto login to the command line using the command

>sudo raspi-config  

Under boot options select Desktop / CLI and then the Console Autologin option.  You can now clone my repo and run make to build the binaries described above.

With the touch screen installed you should see the display show the usual boot up progress messages and finish with the command prompt.  You can now plug in a key-board and use the touch screen as a passive display.


## end





