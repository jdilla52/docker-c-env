FROM ubuntu:20.04 as base

# Set the timezone (necessary to keep soem apt-get packages quiet during install)
RUN ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime

# Install dependencies
RUN DEBIAN_FRONTEND="noninteractive" \
    apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    clang \
    clang-tools \
    clang-tidy \
    lldb \
    ninja-build \
    make \
    libcurl4-openssl-dev \
    vim \
    python3-pip \
    libssl-dev \
    graphviz \
    lld \
    ghostscript \
    autoconf \
    automake \
    libtool \
    unzip \
    && rm -rf /var/lib/apt/lists/*

ENV CC=clang
ENV CXX=clang++

# Install cmake
RUN curl https://cmake.org/files/v3.21/cmake-3.21.3-linux-x86_64.tar.gz > /cmake-3.21.3-linux-x86_64.tar.gz && \
	cd / && rm -rf /opt/cmake-3.21.3-linux-x86_64 && \
    tar -xvzf cmake-3.21.3-linux-x86_64.tar.gz && \
    mv /cmake-3.21.3-linux-x86_64 /opt && \
    rm /cmake-3.21.3-linux-x86_64.tar.gz && \
	rm -rf /opt/cmake-3.21.3-linux-x86_64/doc && \
    ln -sf /opt/cmake-3.21.3-linux-x86_64/bin/cmake /usr/local/bin/cmake

#Getting prebuilt binary from llvm
RUN curl -SL https://github.com/llvm/llvm-project/releases/download/llvmorg-12.0.0/clang+llvm-12.0.0-x86_64-linux-gnu-ubuntu-20.04.tar.xz \
 | tar -xJC . && \
 mv clang+llvm-12.0.0-x86_64-linux-gnu-ubuntu-20.04 clang_12 && \
 echo ‘export PATH=/clang_12/bin:$PATH’ >> ~/.bashrc && \
 echo ‘export LD_LIBRARY_PATH=/clang_12/lib:$LD_LIBRARY_PATH’ >> ~/.bashrc