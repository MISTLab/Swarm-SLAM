#! /usr/bin/env bash

if (( EUID == 0 )); then
	SUDO=""
else
	SUDO="sudo"
fi


$SUDO add-apt-repository universe
$SUDO apt update


DEPS_0="curl git sudo apt-utils ncurses-term locales"
DEPS_1="libboost-all-dev cmake libtbb-dev  intel-mkl-full python3-rosdep python3-colcon-common-extensions sudo git software-properties-common python3-dev python3-full python3-pip"
DEPS_2="ros-dev-tools ros-jazzy-desktop ros-jazzy-rtabmap ros-jazzy-rtabmap-msgs ros-jazzy-navigation2 ros-jazzy-nav2-bringup  ros-jazzy-nav2-minimal-tb* ros-jazzy-perception-pcl ros-jazzy-rtabmap-conversions ros-rolling-cv-bridge "

$SUDO apt install -y $DEPS_0


$SUDO locale-gen en_US en_US.UTF-8
$SUDO update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

git clone https://github.com/anadon/cslam.git
git clone https://github.com/lajoiepy/cslam_interfaces.git 
git clone https://github.com/lajoiepy/cslam_experiments.git 
git clone https://github.com/borglab/gtsam.git 

$SUDO apt install -y $DEPS_1

$SUDO curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo "$UBUNTU_CODENAME") main" | sudo tee "/etc/apt/sources.list.d/ros2.list" > /dev/null


$SUDO apt update
$SUDO apt install -y $DEPS_2

pip install -r requirements.txt


pushd gtsam || exit 1

echo "WARNING!!! This deviates from the Swarm-Slam instructions by using gtsam v4.2 and not 4.1.1."
mkdir build
cd build || exit 1
cmake ..
 # make check (optional, runs unit tests)
$SUDO make install

popd || exit 1

##################
# ROS 2 OS SETUP #
##################

echo "WARNING!!! This deviates from Swarm-Slam instructions by using ROS 2 Jazzy instead of Foxy"
echo "WARNING!!! This is setting up a one-time configuration change because it is destructive to your environment.  This installer is REQUIRING that you take manual action to make this change permenent."

# Replace ".bash" with your shell if you're not using bash
# Possible values are: setup.bash, setup.sh, setup.zsh

echo 'source "/opt/ros/jazzy/setup.bash"' >> ~/.bashrc 
source "/opt/ros/jazzy/setup.bash"

$SUDO rosdep init

rosdep update
rosdep install --from-paths src -y --ignore-src --rosdistro jazzy 

pushd cslam_interfaces || exit 1
colcon build
  echo 'source "/Swarm-Slam/cslam_interfaces/install/setup.bash"' >> "$HOME/.bashrc"
  source "/Swarm-Slam/cslam_interfaces/install/setup.bash"
popd || exit 1

colcon build
colcon test 
