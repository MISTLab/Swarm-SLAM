# Swarm-SLAM: Sparse Decentralized Collaborative Simultaneous Localization and Mapping Framework for Multi-Robot Systems

![Swarm-SLAM Overview](media/system-overview.svg)

[Swarm-SLAM](https://arxiv.org/abs/2301.06230) is an open-source C-SLAM system designed to be scalable, flexible, decentralized, and sparse, which are all key properties in swarm robotics. Our system supports lidar, stereo, and RGB-D sensing, and it includes a novel inter-robot loop closure prioritization technique that reduces inter-robot communication and accelerates the convergence.

Look up our [Documentation](https://lajoiepy.github.io/cslam_documentation/html/index.html) and our [Start-up instructions](https://lajoiepy.github.io/cslam_documentation/html/md_startup-instructions.html)!

Packages summary:
- [cslam](https://github.com/lajoiepy/cslam): contains the Swarm-SLAM nodes;
- [cslam_interfaces](https://github.com/lajoiepy/cslam_interfaces): contains the custom ROS 2 messages;
- [cslam_experiments](https://github.com/lajoiepy/cslam_experiments): contains examples of launch files and configurations for different setups;
- [cslam_visualization](https://github.com/lajoiepy/cslam_visualization): contains an online (optional) visualization tool to run on your base station to monitor the mapping progress.

Follow the [start-up instructions](https://lajoiepy.github.io/cslam_documentation/html/md_startup-instructions.html) to install, build and run Swarm-SLAM.

How to cite [our paper](https://arxiv.org/abs/2301.06230):
```
@ARTICLE{lajoieSwarmSLAMSparseDecentralized2023,
  title = {Swarm-{{SLAM}} : {{Sparse Decentralized Collaborative Simultaneous Localization}} and {{Mapping Framework}} for {{Multi-Robot Systems}}},
  author = {Lajoie, Pierre-Yves and Beltrame, Giovanni},
  year = {2023},
  eprint = {2301.06230},
  eprinttype = {arxiv},
}
```

To clone the code:
```
sudo apt install python3-vcstool
git clone https://github.com/MISTLab/Swarm-SLAM.git
cd Swarm-SLAM
mkdir src
vcs import src < cslam.repos
```
