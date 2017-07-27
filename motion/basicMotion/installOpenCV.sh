#!/bin/sh

# http://www.pyimagesearch.com/2015/10/26/how-to-install-opencv-3-on-raspbian-jessie/

# http://www.pyimagesearch.com/2015/07/27/installing-opencv-3-0-for-both-python-2-7-and-python-3-on-your-raspberry-pi-2/


#The first thing we should do is update and upgrade any existing packages, followed by updating the Raspberry Pi firmware.

#Installing OpenCV 3 on Raspbian JessieShell

sudo apt-get -y update
sudo apt-get -y upgrade
sudo rpi-update
# Timing: 3m 33s

# You’ll need to reboot your Raspberry Pi after the firmware update:
##sudo reboot

# Now we need to install a few developer tools:
sudo apt-get -y install build-essential git cmake pkg-config
# Timing: 51s

# Now we can move on to installing image I/O packages which allow us to load image file formats such as JPEG, PNG, TIFF, etc.:

sudo apt-get -y install libjpeg-dev libtiff5-dev libjasper-dev libpng12-dev
# Timing: 42s

# Just like we need image I/O packages, we also need video I/O packages. These packages allow us to load various video file formats as well as work with video streams:

sudo apt-get -y install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt-get -y install libxvidcore-dev libx264-dev
# Timing: 58s

# We need to install the GTK development library so we can compile the highgui  sub-module of OpenCV, which allows us to display images to our screen and build simple GUI interfaces:

sudo apt-get -y install libgtk2.0-dev
# Timing: 2m 48s

# Various operations inside of OpenCV (such as matrix operations) can be optimized using added dependencies:

sudo apt-get -y install libatlas-base-dev gfortran
# Timing: 50s

# Lastly, we’ll need to install the Python 2.7 and Python 3 header files so we can compile our OpenCV + Python bindings:
sudo apt-get -y install python2.7-dev python3-dev



# http://www.pyimagesearch.com/2015/07/27/installing-opencv-3-0-for-both-python-2-7-and-python-3-on-your-raspberry-pi-2/

# At this point we have all our prerequisites installed, so let’s pull down the OpenCV repository from GitHub and checkout the 3.0.0  version:

## Installing OpenCV 3.0 for both Python 2.7 and Python 3+ on your Raspberry Pi 2Shell
#cd ~
#git clone https://github.com/Itseez/opencv.git
#cd opencv
#git checkout 3.2.0
## Timings: 8m 34s

## Update (3 January 2016): You can replace the 3.0.0  version with whatever the current release is (as of right now, it’s 3.1.0 ). Be sure to check OpenCV.org for information on the latest release.

## For the full, complete install of OpenCV 3.0, grab the opencv_contrib repo as well:

## Installing OpenCV 3.0 for both Python 2.7 and Python 3+ on your Raspberry Pi 2Shell

#cd ~
#git clone https://github.com/Itseez/opencv_contrib.git
#cd opencv_contrib
#git checkout 3.2.0
## Timings: 1m 7s

## Again, make sure that you checkout the same version for opencv_contrib  that you did for opencv  above, otherwise you could run into compilation errors.


#Install pip , a Python package manager that is compatible with Python 2.7:
wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py
# Timings: 33s

# Just as we did in the original tutorial on installing OpenCV 2.4.X on your Raspberry Pi, we are going to utilize virtualenv and virtualenvwrapper which allow us to create separate Python environments for each of our Python projects. Installing virtualenv  and virtualenvwrapper  is certainly not a requirement when installing OpenCV and Python bindings; however, it’s a standard Python development practice, one that I highly recommend, and the rest of this tutorial will assume you are using them!
#
#Installing virtualenv  and virtualenvwrapper  is as simple as using the pip  command:

sudo pip install virtualenv virtualenvwrapper
sudo rm -rf ~/.cache/pip
# Timings: 17s


## Next up, we need to update our ~/.profile  file by opening it up in your favorite editor and adding the following lines to the bottom of the file.
## virtualenv and virtualenvwrapper
#export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2.7
#export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh


#Time to create the cv3  virtual environment where we’ll do our computer vision work:
#mkvirtualenv cv3
# Timings: 19s

# If you ever need to access the cv3  virtual environment (such as after you logout or reboot your Pi), just source  your ~/.profile  file (to ensure it has been loaded) and use the workon  command:

workon cv3
# And your shell will be updated to only use packages in the cv3  virtual environment.

#Moving on, the only Python dependency we need is NumPy, so ensure that you are in the cv3  virtual environment and install NumPy:

# While unlikely, I have seen instances where the .cache  directory gives a “Permission denied” error since we used the sudo  command to install pip . If that happens to you, just remove the .cache/pip  directory and re-install NumPy:

sudo rm -rf ~/.cache/pip/
pip install numpy
# Timings 13m 47s


# And once you are in cv3  virtual environment, you can use cmake  to setup the build:
cd ~/opencv
mkdir build
cd build
cmake 	-D CMAKE_BUILD_TYPE=RELEASE \
	-D CMAKE_INSTALL_PREFIX=/usr/local \
	-D INSTALL_C_EXAMPLES=OFF \
	-D INSTALL_PYTHON_EXAMPLES=ON \
	-D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
	-D BUILD_EXAMPLES=ON ..
#### Update (3 January 2016): In order to build OpenCV 3.1.0 , you need to set -D INSTALL_C_EXAMPLES=OFF  (rather than ON ) in the cmake  command. There is a bug in the OpenCV v3.1.0 CMake build script that can cause errors if you leave this switch on. Once you set this switch to off, CMake should run without a problem.

# CMake will run for about 30 seconds, and after it has completed (assuming there are no errors), you will want to inspect the output, especially the Python 2 section:

#All that is left now is to compile OpenCV 3.0:
make -j4
#Where the 4 corresponds to the 4 cores on our Raspberry Pi 2.
# Timings: 65m 33s

#Assuming OpenCV has compiled without an error, you can now install it on your Raspberry Pi:
sudo make install
sudo ldconfig
#At this point, OpenCV 3.0 has been installed on your Raspberry Pi 2 � there is just one more step to take.
# Remember how I mentioned the packages path  above?
# Take a second to investigate the contents of this directory, in my case /usr/local/lib/python2.7/site-packages/ :
# You should see a file named cv2.so , which is our actual Python bindings. The last step we need to take is sym-link the cv2.so  file into the site-packages  directory of our cv3  environment:

cd ~/.virtualenvs/cv3/lib/python2.7/site-packages/
ln -s /usr/local/lib/python2.7/site-packages/cv2.so cv2.so

# make sure you are in the cv3 virtual workspace
source /usr/local/bin/virtualenvwrapper.sh
workon cv3

python
>>> import cv2
>>> cv2.__version__3
'3.0.2'


#  http://www.pyimagesearch.com/2015/03/30/accessing-the-raspberry-pi-camera-with-opencv-and-python/

# Test out the install and the camera
cd
raspistill -o output.jpg
# then open output.jpg

pip install "picamera[array]"
pip install imutils




sudo apt-get -y autoremove
sudo apt-get -y clean


