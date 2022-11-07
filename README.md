
Install [ROS 2](https://docs.ros.org/en/foxy/Installation/Ubuntu-Install-Debians.html)

Install [miniconda](https://docs.conda.io/en/latest/miniconda.html)

sudo apt install python3-vcstool

mkdir src

vcs import src < cslam.repos 

conda create --name cslam

conda activate cslam

pip install -r requirements.txt # You don't need torch if you are only using lidar.

Install gtsam: https://github.com/borglab/gtsam

If you are using lidar, install teaser++ with python bindings: https://teaser.readthedocs.io/en/latest/installation.html#installing-python-bindings

sudo rosdep init
rosdep update
rosdep install --from-paths src -y --ignore-src --rosdistro foxy

source /opt/ros/foxy/setup.bash
colcon build
colcon test
