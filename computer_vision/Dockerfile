FROM nvidia/cuda:12.9.2-cudnn-devel-ubuntu24.04

SHELL ["/bin/bash", "-c"]
ENV TERM=xterm-256color

# Install GCC 15.
RUN --mount=type=cache,target=/var/cache/apt \
  apt-get update && \
  apt-get install --no-install-recommends -y \
  software-properties-common && \
  add-apt-repository ppa:ubuntu-toolchain-r/test -y && \
  apt-get update && \
  apt-get install --no-install-recommends -y \
  gcc-15 \
  g++-15 \
  libstdc++-15-dev && \
  rm -rf /var/lib/apt/lists/*

# Set GCC 15 as the default compiler.
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-15 100 \
  --slave /usr/bin/g++ g++ /usr/bin/g++-15 \
  --slave /usr/bin/gcov gcov /usr/bin/gcov-15
ENV CC=gcc-15 CXX=g++-15

# Install base packages.
RUN --mount=type=cache,target=/var/cache/apt \
  apt-get update && \
  apt-get install --no-install-recommends -y \
  sudo \
  lsb-release \
  wget \ 
  curl \ 
  bash-completion \
  gdb \
  cmake \ 
  cmake-curses-gui \
  gdb \ 
  python3-pip \
  python3-venv \
  libomp-dev \
  git \
  vim \ 
  ninja-build \
  tree \
  htop \
  libyaml-cpp-dev \
  libspdlog-dev \
  libgflags-dev \
  libgoogle-glog-dev \
  libatlas-base-dev \
  libgtest-dev \
  libeigen3-dev \
  libceres-dev \
  libopencv-dev \
  python3-opencv && \
  rm -rf /var/lib/apt/lists/*

# Install Sophus.
RUN cd ${HOME} && \
  git clone https://github.com/strasdat/Sophus.git && \
  cd Sophus && \
  mkdir build && \
  cd build && \
  cmake -G Ninja .. -DCMAKE_BUILD_TYPE=Release -DBUILD_SOPHUS_TESTS=OFF -DBUILD_SOPHUS_EXAMPLES=OFF && \
  ninja -j8 && \
  ninja install && \
  cd ${HOME} && \
  rm -rf Sophus


# To enable Matplotlib visualization from python script.
RUN --mount=type=cache,target=/var/cache/apt \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
  python3-tk \
  libtbb-dev && \
  rm -rf /var/lib/apt/lists/*

# Install Pangolin.
RUN --mount=type=cache,target=/var/cache/apt \
  apt-get update && \
  apt-get install --no-install-recommends -y \
  libgl-dev 
RUN cd ${HOME} && \
  git clone --recursive https://github.com/stevenlovegrove/Pangolin.git && \
  cd Pangolin && \
  cd scripts && \
  yes | ./install_prerequisites.sh recommended && \
  cd .. && \
  mkdir build && \
  cd build && \
  cmake .. \
    -DCMAKE_CXX_FLAGS="-Wno-error=missing-braces" \
    -DBUILD_PANGOLIN_DEPTHSENSE=OFF \
    -DBUILD_PANGOLIN_REALSENSE=OFF \
    -DBUILD_PANGOLIN_REALSENSE2=OFF \
    -DBUILD_PANGOLIN_PYTHON=OFF \
    -DBUILD_TESTS=OFF \
    -DBUILD_EXAMPLES=OFF \
    -DBUILD_ASAN=OFF \
    -DCMAKE_BUILD_TYPE=Release && \
  make -j8 && \
  make install && \
  cd ${HOME} && \
  rm -rf Pangolin

# Install gtsam.
RUN add-apt-repository ppa:borglab/gtsam-develop && \
  apt update && \
  apt install --no-install-recommends -y \
  libboost-dev \
  libboost-serialization-dev \
  libboost-system-dev \
  libboost-filesystem-dev \
  libboost-thread-dev \
  libboost-program-options-dev \
  libboost-date-time-dev \
  libboost-chrono-dev \
  libboost-timer-dev \
  libboost-regex-dev && \
  rm -rf /var/lib/apt/lists/*

RUN cd ${HOME} && \
  git clone --depth 1 --branch 4.2.0 https://github.com/borglab/gtsam.git && \
  cd gtsam && mkdir build && cd build && \
  cmake -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DGTSAM_BUILD_TESTS=OFF \
    -DGTSAM_BUILD_EXAMPLES_ALWAYS=OFF \
    -DGTSAM_USE_SYSTEM_EIGEN=ON \
    -DGTSAM_WITH_TBB=ON \
    -DGTSAM_BUILD_UNSTABLE=ON \
    .. && \
  ninja -j8 && ninja install && ldconfig && \
  cd ${HOME} && rm -rf gtsam

# Install argparse.
RUN cd ${HOME} && \
  git clone https://github.com/p-ranav/argparse && \
  cd argparse && \
  mkdir build && \
  cd build && \
  cmake \ 
    -DARGPARSE_BUILD_SAMPLES=OFF \
    -DARGPARSE_BUILD_TESTS=OFF \
    -DARGPARSE_INSTALL=ON .. && \
  make && \
  make install && ldconfig && \
  cd ${HOME} && \
  rm -rf argparse

  # RUN --mount=type=cache,target=/var/cache/apt \
  # apt-get update && \
  # apt-get install --no-install-recommends -y \
  # clangd && \
  # rm -rf /var/lib/apt/lists/*

# ubuntu:latest image comes with default nonroot user named "ubuntu". 
# The following lines customize that name and group and move the home directory. 
ARG USERNAME=cv-dev
ARG USER_UID=1000
ARG USER_GID=${USER_UID}
RUN usermod -l ${USERNAME} ubuntu -u ${USER_UID}
RUN usermod -md /home/${USERNAME} ${USERNAME}
RUN groupmod -n ${USERNAME} ubuntu 
RUN usermod -aG sudo ${USERNAME}
RUN echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
ENV HOME=/home/${USERNAME}
