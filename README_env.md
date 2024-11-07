# Setting up dockerized environment

## Host System Configuration

### System Requirements

- Ubuntu 20.04-22.04-24.04 (Dev & Testing performed on 22.04)
- NVIDIA GPU with compute capability 8.6 ([compute capability details](https://developer.nvidia.com/cuda-gpus#compute))
- NVIDIA driver ([driver installation guide](https://docs.nvidia.com/datacenter/tesla/driver-installation-guide/index.html))
- CUDA version 11.1 or higher ([CUDA installation guide](https://docs.nvidia.com/cuda/cuda-installation-guide-linux)) ([More about CUDA](https://en.wikipedia.org/wiki/CUDA))

### Install Docker

- Follow the guide [here](https://docs.docker.com/engine/install/ubuntu/)
- Add user to docker group

```bash
sudo usermod -aG docker $USER
```

### Add NVIDIA Container Toolkit

- Follow the guide [here](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker)

- Configure the runtime

```bash
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker
```

- Verify the installation

```bash
sudo docker run --rm --runtime=nvidia --gpus all ubuntu nvidia-smi
```

## Evaluate in Visual Studio

Make sure that the dev container extension is installed

- From the command window in visual studio choose dev containers: rebuild and open in container for first time. Just reopen in remote container every other time.
- Run ./command_infer_vis_grasp.sh
