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
COPY requirements.txt /app/
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