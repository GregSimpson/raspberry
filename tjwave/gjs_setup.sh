# https://github.com/victordibia/tjwave 
#git clone https://github.com/victordibia/tjwave.git
sudo apt-get install alsa-base alsa-utils
sudo apt-get install libasound2-dev
sudo apt-get install pigpio
npm install
sudo rm -rf node_modules
sudo npm install --unsafe-perm

# This sets the audio output to option 1 which is your Pi's Audio Jack. Option 0 = Auto, Option 2 = HDMI. An alternative is to type sudo raspi-config and change the audio to 3.5mm audio jack.
amixer cset numid=3 1    

## -----
## On your local machine rename the config.default.js file to config.js.
#cp config.default.js config.js
#
## Open config.js using your favorite text editor # (e.g // nano) and update it with your Bluemix credentials for the Watson services you use.
#

sudo node wavetest.js

