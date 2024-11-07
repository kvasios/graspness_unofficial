FROM pytorch/pytorch:1.9.1-cuda11.1-cudnn8-devel

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
 && rm -rf /var/lib/apt/lists/*

# Create a working directory
RUN mkdir /workspace
WORKDIR /workspace

# Create a non-root user and switch to it
RUN adduser --disabled-password --gecos '' --shell /bin/bash user \
 && echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN chown -R user:user /workspace

USER user

# All users can use /home/user as their home directory
ENV HOME=/home/user
RUN mkdir -p $HOME/.cache $HOME/.config \
 && chmod -R 777 $HOME

# Copy the requirements.txt file into the image
COPY requirements.txt /workspace/

# Install Python packages
RUN pip install --no-cache-dir -r /workspace/requirements.txt

# # Copy the pointnet2 and knn directories into the image
COPY pointnet2 /workspace/pointnet2
COPY knn /workspace/knn

# Install pointnet2
RUN cd /workspace/pointnet2 && python setup.py install --user

# Install knn
RUN cd /workspace/knn && python setup.py install --user

# Copy the graspnetAI directory into the image
COPY graspnetAI /workspace/graspnetAI

# Install graspnetAI
RUN cd /workspace/graspnetAI && pip install .

# Set the default command to python3
CMD ["python3"]