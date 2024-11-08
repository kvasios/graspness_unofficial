ARG PYTORCH="1.9.1"
ARG CUDA="11.1"
ARG CUDNN="8"

FROM pytorch/pytorch:${PYTORCH}-cuda${CUDA}-cudnn${CUDNN}-devel

##############################################
# You should modify this to match your GPU compute capability
# ENV TORCH_CUDA_ARCH_LIST="6.0 6.1 7.0+PTX"
ENV TORCH_CUDA_ARCH_LIST="8.6"
##############################################

ENV TORCH_NVCC_FLAGS="-Xfatbin -compress-all"

# Remove any third-party apt sources to avoid issues with expiring keys.
RUN rm -f /etc/apt/sources.list.d/*.list

# Install some basic utilities and libgl1-mesa-glx
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    sudo \
    git \
    bzip2 \
    libx11-6 \
    libopenblas-dev \
    libgl1-mesa-glx \
    libglib2.0-0 \
    ninja-build \
    cmake \
    build-essential \
    xterm \
    xauth \
    openssh-server \
    tmux \
    wget \
    mate-desktop-environment-core \
 && rm -rf /var/lib/apt/lists/*

 RUN apt-get clean
 RUN rm -rf /var/lib/apt/lists/*

# For faster build, use more jobs.
ENV MAX_JOBS=4
RUN git clone --recursive "https://github.com/NVIDIA/MinkowskiEngine"
RUN cd MinkowskiEngine; python setup.py install --force_cuda --blas=openblas

# Create a working directory
RUN mkdir /app

# Create a non-root user and switch to it
RUN adduser --disabled-password --gecos '' --shell /bin/bash user \
 && echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN chown -R user:user /app

USER user

# All users can use /home/user as their home directory
ENV HOME=/home/user
RUN mkdir -p $HOME/.cache $HOME/.config \
 && chmod -R 777 $HOME

# Copy the requirements file and install Python packages
COPY ../requirements.txt /app/
RUN pip install --no-cache-dir -r /app/requirements.txt

USER root

# Copy pointnet2 directory and install it
COPY pointnet2 /app/pointnet2
RUN cd /app/pointnet2 && python setup.py install

# Copy knn directory and install it
COPY knn /app/knn
RUN cd /app/knn && python setup.py install

# Install graspnetAI
COPY graspnetAPI /app/graspnetAI
RUN cd /app/graspnetAI && pip install .

USER user

# Set the default command to python3
CMD ["python3"]

WORKDIR /app