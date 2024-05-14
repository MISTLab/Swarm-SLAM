# Swarm-SLAM: Sparse Decentralized Collaborative Simultaneous Localization and Mapping Framework for Multi-Robot Systems ![Build Status](https://github.com/MISTLab/Swarm-SLAM/actions/workflows/main.yml/badge.svg)

![Swarm-SLAM Overview](media/system-overview.svg)

Look up our [Documentation](https://lajoiepy.github.io/cslam_documentation/html/index.html) and our [Start-up instructions](https://lajoiepy.github.io/cslam_documentation/html/md_startup-instructions.html)!

<p align="center">
  <img src="media/graco_pg.gif" alt="Swarm-SLAM on GRACO dataset" width="48%" />
  <img src="media/graco_pc.gif" alt="Swarm-SLAM on GRACO dataset" width="48%" />
</p>

[Swarm-SLAM](https://ieeexplore.ieee.org/document/10321649) is an open-source C-SLAM system designed to be scalable, flexible, decentralized, and sparse, which are all key properties in swarm robotics. Our system supports lidar, stereo, and RGB-D sensing, and it includes a novel inter-robot loop closure prioritization technique that reduces inter-robot communication and accelerates the convergence.

To clone Swarm-SLAM:
```
sudo apt install python3-vcstool
git clone https://github.com/MISTLab/Swarm-SLAM.git
cd Swarm-SLAM
mkdir src
vcs import src < cslam.repos
```

Packages summary:
- [cslam](https://github.com/lajoiepy/cslam): contains the Swarm-SLAM nodes;
- [cslam_interfaces](https://github.com/lajoiepy/cslam_interfaces): contains the custom ROS 2 messages;
- [cslam_experiments](https://github.com/lajoiepy/cslam_experiments): contains examples of launch files and configurations for different setups;
- [cslam_visualization](https://github.com/lajoiepy/cslam_visualization): contains an online (optional) visualization tool to run on your base station to monitor the mapping progress.

Follow the [start-up instructions](https://lajoiepy.github.io/cslam_documentation/html/md_startup-instructions.html) to install, build and run Swarm-SLAM.

How to cite [our paper](https://ieeexplore.ieee.org/document/10321649):
```
@ARTICLE{lajoieSwarmSLAM,
  author={Lajoie, Pierre-Yves and Beltrame, Giovanni},
  journal={IEEE Robotics and Automation Letters}, 
  title={Swarm-SLAM: Sparse Decentralized Collaborative Simultaneous Localization and Mapping Framework for Multi-Robot Systems}, 
  year={2024},
  volume={9},
  number={1},
  pages={475-482},
  doi={10.1109/LRA.2023.3333742}
}

```

