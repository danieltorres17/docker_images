FROM rust:latest

SHELL ["/bin/bash", "-c"]
ENV TERM=xterm-256color

RUN --mount=type=cache,target=/var/cache/apt \
  apt-get update && \
  apt-get install --no-install-recommends -y \
  lsb-release \
  wget \
  curl \
  sudo \
  bash-completion \
  build-essential \
  git \
  vim \
  make \
  tree && \
  rm -rf /var/lib/apt/lists/*

RUN rustup component add rustfmt

ARG USERNAME=rust-dev
ARG USER_UID=1000
ARG USER_GID=${USER_UID}
RUN useradd -m ${USERNAME} -u ${USER_UID} && echo "${USERNAME}:${USERNAME}" | chpasswd 
RUN usermod -aG sudo ${USERNAME}
