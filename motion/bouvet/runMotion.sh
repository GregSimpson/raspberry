#!/usr/bin/env bash
# sudo raspi-config
# This will open the Raspberry Pi Configuration tool, from which you should do the following:

# Enable the Camera.
# Enable the ssh server (you will need this later on to connect to Pi Zero in headless mode - i.e. without a monitor and keyboard attached).
# Enable boot to command line without manual login.

#sudo apt-get -y update
#sudo apt-get -y dist-upgrade

####  camera still shot test
## https://www.raspberrypi.org/documentation/usage/camera/raspicam/README.md
#DATE=$(date +"%Y-%m-%d_%H%M")
#raspistill -vf -hf -o /home/pi/raspberry/motion/bouvet/images/$DATE.jpg

# https://www.bouvet.no/bouvet-deler/utbrudd/building-a-motion-activated-security-camera-with-the-raspberry-pi-zero

# download it from here
# https://github.com/Motion-Project/motion/releases/tag/release-4.0.1

# sudo apt-get -y install gdebi-core

# sudo gdebi pi_jessie_motion_4.0.1-1_armhf.deb
# mkdir ~/.motion
# cp /etc/motion/motion.conf ~/.motion/motion.conf

# gvim ~/.motion/motion.conf
#  Remember that you always have a clean copy of the config file at  /etc/motion/motion.conf.

# https://www.raspberrypi.org/forums/viewtopic.php?t=76558&p=546467
# sudo rpi-update

## !!! gjs
# fails with /dev/video0 : No such file or directory
# answer:
# https://raspberrypi.stackexchange.com/questions/10480/raspi-camera-board-and-motion/22924
#sudo modprobe bcm2835-v4l2

# http://www.richardmudhar.com/blog/2015/02/raspberry-pi-camera-and-motion-out-of-the-box-sparrowcam/
# to load modprobe at boot time add this line to
# /etc/modules
#   # camera with v4l2 driver
#   bcm2835-v4l2

touch /home/pi/runMotion-TRIED-to-start
#sleep 10
motion -c /home/pi/.motion/motion.conf
touch /home/pi/runMotion-PASSED-to-start

