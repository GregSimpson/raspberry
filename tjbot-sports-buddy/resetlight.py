
# http://raspberrypi.powersbrewery.com/project-6-rgb-led/

#!/usr/bin/env python

# Import the modules used in the script
import random, time
import RPi.GPIO as GPIO
from random import randint
 
# Set GPIO to Broadcom system and set RGB Pin numbers
GPIO.cleanup()
