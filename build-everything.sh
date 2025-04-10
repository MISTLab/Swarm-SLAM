#!/usr/bin/env bash

### Installation script for ROS 2 (tested with Humble and Jazzy)
## Credits to @anadon

set -e

# Usage: ./install.sh [add_ros_setup (true/false)] [shell_type (bash/zsh)]
ADD_ROS_SETUP=${1:-true}
SHELL_TYPE=${2:-bash}
RC_FILE="$HOME/.${SHELL_TYPE}rc"
WORKSPACE_DIR="$(pwd)"

if (( EUID == 0 )); then
	SUDO=""
else
	SUDO="sudo"
fi

$SUDO add-apt-repository universe
$SUDO apt update

export DEBIAN_FRONTEND=noninteractive

DEPS_0="curl git sudo apt-utils dialog locales"
DEPS_1="libboost-all-dev cmake libtbb-dev intel-mkl-full python3-rosdep python3-colcon-common-extensions sudo git software-properties-common python3-dev python3-full python3-pip"
DEPS_2="ros-dev-tools ros-$ROS_DISTRO-desktop ros-$ROS_DISTRO-rtabmap ros-$ROS_DISTRO-rtabmap-msgs ros-$ROS_DISTRO-navigation2 ros-$ROS_DISTRO-nav2-bringup ros-$ROS_DISTRO-perception-pcl ros-$ROS_DISTRO-rtabmap-conversions ros-rolling-cv-bridge"

$SUDO apt install -y $DEPS_0

$SUDO locale-gen en_US en_US.UTF-8
$SUDO update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

declare -A REPOS=(
  ["cslam"]="https://github.com/lajoiepy/cslam.git"
  ["cslam_interfaces"]="https://github.com/lajoiepy/cslam_interfaces.git"
  ["cslam_experiments"]="https://github.com/lajoiepy/cslam_experiments.git"
  ["gtsam"]="https://github.com/borglab/gtsam.git"
)

for repo in "${!REPOS[@]}"; do
  if [ ! -d "$repo" ]; then
    git clone "${REPOS[$repo]}"
  else
    echo "Repo $repo already cloned. Skipping."
  fi
done

$SUDO apt install -y $DEPS_1

$SUDO curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo "$UBUNTU_CODENAME") main" | $SUDO tee /etc/apt/sources.list.d/ros2.list > /dev/null

$SUDO apt update
$SUDO apt install -y $DEPS_2

pip install -r requirements.txt

pushd gtsam || exit 1
echo "WARNING!!! This deviates from the Swarm-Slam instructions by using gtsam v4.2 and not 4.1.1."
mkdir -p build
cd build || exit 1
cmake ..
make -j$(nproc)
$SUDO make install
popd || exit 1

##################
# ROS 2 OS SETUP #
##################

echo "WARNING!!! Using newer ROS 2 versions (like Humble or Jazzy) instead of Foxy"

if [[ "$ADD_ROS_SETUP" == "true" ]]; then
	echo "Adding ROS environment setup to $RC_FILE"
	echo 'source "/opt/ros/$ROS_DISTRO/setup.'"$SHELL_TYPE"'"' >> "$RC_FILE"
	source "/opt/ros/$ROS_DISTRO/setup.$SHELL_TYPE"
fi

$SUDO rosdep init || echo "rosdep already initialized"
if ! rosdep update; then
  echo "WARNING: rosdep update failed — continuing anyway"
fi
if ! rosdep install --from-paths src -y --ignore-src --rosdistro $ROS_DISTRO; then
  echo "WARNING: rosdep install failed — continuing anyway"
fi

pushd cslam_interfaces || exit 1
colcon build
if [[ "$ADD_ROS_SETUP" == "true" ]]; then
	echo 'source "'"$WORKSPACE_DIR"'/cslam_interfaces/install/setup.'"$SHELL_TYPE"'"' >> "$RC_FILE"
  source "$WORKSPACE_DIR/cslam_interfaces/install/setup.$SHELL_TYPE"
fi
popd || exit 1

colcon build
colcon test

if [[ "$ADD_ROS_SETUP" == "true" ]]; then
	echo 'source "'"$WORKSPACE_DIR"'/install/setup.'"$SHELL_TYPE"'"' >> "$RC_FILE"
  source "$WORKSPACE_DIR/install/setup.$SHELL_TYPE"
fi
