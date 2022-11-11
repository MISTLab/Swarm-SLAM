
Install [ROS 2](https://docs.ros.org/en/foxy/Installation/Ubuntu-Install-Debians.html)

Install [miniconda](https://docs.conda.io/en/latest/miniconda.html)

sudo apt install python3-vcstool

mkdir src

vcs import src < cslam.repos 

conda create --name cslam (TODO: use venv instead)

conda activate cslam

sudo apt install python3-pip
pip install -r requirements.txt # You don't need torch if you are only using lidar.

Install gtsam: https://github.com/borglab/gtsam
git checkout 4.1.1 (tested)

If you are using lidar, install teaser++ with python bindings: https://teaser.readthedocs.io/en/latest/installation.html#installing-python-bindings

sudo apt install python3-rosdep python3-colcon-common-extensions
source /opt/ros/foxy/setup.bash
sudo rosdep init
rosdep update
rosdep install --from-paths src -y --ignore-src --rosdistro foxy

source /opt/ros/foxy/setup.bash
colcon build
colcon test

For images, download CosPlace model ResNet-18 dimension 64 : https://github.com/gmberton/CosPlace

Other models can be used by modifying frontend.cosplace.descriptor_dim and frontend.cosplace.backbone params accordingly.

Place the model file in src/cslam/models/
Set frontend.nn_checkpoint accordingly

Run experiments

Where to download and how to convert from ros1 bags to ros 2.

M2DGR:
Lio-sam: https://github.com/TixiaoShan/LIO-SAM/tree/ros2
sudo apt install ros-foxy-xacro