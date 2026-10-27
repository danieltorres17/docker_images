FROM ubuntu:24.04

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

RUN --mount=type=cache,target=/var/cache/apt \
  apt-get update && \
  apt-get install --no-install-recommends -y \
  sudo \ 
  lsb-release \
  wget \ 
  curl \ 
  bash-completion \
  libc6-dev \
  make \
  cmake \ 
  cmake-curses-gui \
  ca-certificates \
  libssl-dev \
  gpg \
  gdb \
  git \
  ninja-build \
  valgrind \
  python3-dev \
  python3-pip && \
  rm -rf /var/lib/apt/lists/*

# Install argparse library.
WORKDIR /root/temp
RUN git clone https://github.com/p-ranav/argparse.git && \
  cd argparse && \
  mkdir build && \
  cd build && \
  cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DARGPARSE_BUILD_SAMPLES=OFF \
    -DARGPARSE_BUILD_TESTS=OFF \
    .. && \
  make -j8 && \
  make install && \
  ldconfig && \
  cd ../.. && \ 
  rm -rf argparse

RUN --mount=type=cache,target=/var/cache/apt \
  apt-get update && \
  apt-get install --no-install-recommends -y \
  tree \
  sqlite3 \
  libsqlite3-dev \
  linux-tools-generic \
  linux-cloud-tools-generic \
  libspdlog-dev && \
  rm -rf /var/lib/apt/lists/*

# Install ImGUI utils.
RUN --mount=type=cache,target=/var/cache/apt \
  apt-get update && \
  apt-get install --no-install-recommends -y \
  libgl1 \
  freeglut3-dev \
  libglew-dev \
  libglfw3-dev \
  libxrandr-dev \
  libxinerama-dev \
  libxcursor-dev \
  libxi-dev \
  libfreetype6-dev \
  libfmt-dev \
  vim

RUN --mount=type=cache,target=/var/cache/apt \
  apt-get update && \
  apt-get install --no-install-recommends -y \
  pkg-config \
  libglib2.0-dev

# Create a symlink to perf.
RUN ln -s /usr/lib/linux-tools/6.8.0-124-generic/perf /usr/local/bin/perf

# Install zen-c.
RUN git clone --branch v0.4.4 https://github.com/zenc-lang/zenc.git && \
  cd zenc && \
  make clean && \
  make && \
  sudo make install
ENV PATH="/usr/local/bin/zc:${PATH}"

# Install SDL2 and Eigen3.
RUN --mount=type=cache,target=/var/cache/apt \
  apt-get update && \
  apt-get install --no-install-recommends -y \
  libsdl2-2.0-0 \
  libsdl2-dev && \
  rm -rf /var/lib/apt/lists/*
  
# ubuntu:latest image comes with default nonroot user named "ubuntu". 
# The following lines customize that name and group and move the home directory. 
ARG USERNAME=cpp-sandbox
ARG USER_UID=1000
ARG USER_GID=${USER_UID}
RUN usermod -l ${USERNAME} ubuntu -u ${USER_UID}
RUN usermod -md /home/${USERNAME} ${USERNAME}
RUN groupmod -n ${USERNAME} ubuntu 
RUN usermod -aG sudo ${USERNAME}
RUN echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

COPY .bash_aliases /home/${USERNAME}/.bash_aliases
