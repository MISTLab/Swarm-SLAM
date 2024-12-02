#! /usr/bin/env bash

git clone https://github.com/lajoiepy/cslam.git 
git clone https://github.com/lajoiepy/cslam_interfaces.git 
git clone https://github.com/lajoiepy/cslam_experiments.git 

pip install -r requirements.txt

sudo apt-get install libboost-all-dev cmake libtbb-dev  intel-mkl-full python3-rosdep python3-colcon-common-extensions

git clone git@github.com:borglab/gtsam.git 

pushd gtsam || exit 1

echo "WARNING!!! This deviates from the Swarm-Slam instructions by using gtsam v4.2 and not 4.1.1."
mkdir build
cd build || exit 1
cmake ..
 # make check (optional, runs unit tests)
sudo make install

popd || exit 1

##################
# ROS 2 OS SETUP #
##################

echo "WARNING!!! This deviates from Swarm-Slam instructions by using ROS 2 Jazzy instead of Foxy"

locale  # check for UTF-8

sudo apt update && sudo apt install locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

locale  # verify settings

sudo apt install software-properties-common
sudo add-apt-repository universe

sudo apt update && sudo apt install curl -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo "$UBUNTU_CODENAME") main" | sudo tee "/etc/apt/sources.list.d/ros2.list" > /dev/null

sudo apt update && sudo apt install ros-dev-tools

sudo apt update 

sudo apt install ros-jazzy-desktop

echo "WARNING!!! This is setting up a one-time configuration change because it is destructive to your environment.  This installer is REQUIRING that you take manual action to make this change permenent."

# Replace ".bash" with your shell if you're not using bash
# Possible values are: setup.bash, setup.sh, setup.zsh

source "/opt/ros/jazzy/setup.bash"

sudo rosdep init

rosdep update
rosdep install --from-paths src -y --ignore-src --rosdistro jazzy 

colcon test 
