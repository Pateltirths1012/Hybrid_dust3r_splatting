# Hybrid Dust3r Splatting


Hybrid Dust3r Splatting combines DUSt3R's camera-intrinsic-free 3D reconstruction with the efficient, high-quality rendering of Gaussian Splatting. By first using DUSt3R to produce dense, unconstrained stereo pointmaps directly from images -- eliminating the need for known camera parameters -- then refining them into a continuous volumetric field via Gaussian Splatting, this repository enables accurate, fast, and visually compelling 3D scene synthesis and real-time novel-view generation without explicit camera calibration.

## Overview
This project merges DUSt3R's geometric accuracy with 3D Gaussian Splatting's real-time radiance rendering, making it well-suited for augmented reality (AR) or interactive environments where both detailed geometry and smooth rendering are essential.
- Use DUSt3R to perform precise 3D geometric reconstruction of scenes.
- Use 3D Gaussian Splatting to render the appearance of the reconstructed scene in real-time.
- Seamlessly merge the DUSt3R geometric model with the 3D Gaussian Splatting radiance representation for a unified system.
- Evaluate the hybrid system for both accuracy and performance in real-world or simulated scenarios.


## Cloning the Repository

Starting from cloning the repo and installing the submodules

```sh
git clone git@github.com:Pateltirths1012/Hybrid_dust3r_splatting.git --recursive
cd hybrid-duster-splat
git pull --recurse-submodules
git submodule update --init --recursive
```


## Creating virtual environment Manually (Optional)

```sh
virtualenv -p python3.11 hybrid-duster-splt-venv
.\hybrid-duster-splt-venv\Scrips\activate
pip install cmake==3.2.0
```

## Setup

In the activated environment, running the setup.bat script would install the necessary dependencies based on your passed CUDA version argument.

```sh
setup.bat <cuda_version>
```

Supported CUDA versions are 10.2, 11.8, or 12.1

## Interactive Viewers

For enabling interactive viewers follow the readme section from 3D Gaussian splatting repository [here.](https://github.com/nerlfield/gaussian-splatting/blob/main/README.md#interactive-viewers)


## Running the Notebooks

You can run the [run.ipynb](./run.ipynb) notebook on the input data and get a full implementation of the project.

You can also run the [baseline.ipynb](./baseline.ipynb) notebook to input your images into the project and get an implementation on the same directly. This notebook runs the standard Gaussian Splatting model relying on COLMAP to create Gaussian Splatting inputs from user input images. This serves as a baseline against running the Dust3r Splatting model.

