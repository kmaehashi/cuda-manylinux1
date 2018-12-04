# FROM centos:6
FROM quay.io/pypa/manylinux1_x86_64

USER root

###
### https://gitlab.com/nvidia/cuda/raw/centos6/10.0/base/Dockerfile
###

RUN NVIDIA_GPGKEY_SUM=d1be581509378368edeec8c1eb2958702feedf3bc3d17011adbf24efacce4ab5 && \
    curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/rhel6/x86_64/7fa2af80.pub | sed '/^Version/d' > /etc/pki/rpm-gpg/RPM-GPG-KEY-NVIDIA && \
    echo "$NVIDIA_GPGKEY_SUM  /etc/pki/rpm-gpg/RPM-GPG-KEY-NVIDIA" | sha256sum -c -

COPY cuda.repo /etc/yum.repos.d/cuda.repo

ENV CUDA_VERSION 10.0.130

ENV CUDA_PKG_VERSION 10-0-$CUDA_VERSION-1
# For libraries in the cuda-compat-* package: https://docs.nvidia.com/cuda/eula/index.html#attachment-a
RUN yum install -y \
        cuda-cudart-$CUDA_PKG_VERSION \
        cuda-compat-10-0-410.48 && \
    ln -s cuda-10.0 /usr/local/cuda && \
    rm -rf /var/cache/yum/*

ENV PATH /usr/local/cuda/bin:${PATH}

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
ENV NVIDIA_REQUIRE_CUDA "cuda>=10.0 brand=tesla,driver>=384,driver<385"

###
### https://gitlab.com/nvidia/cuda/raw/centos6/10.0/runtime/Dockerfile
###

RUN yum install -y \
        cuda-libraries-$CUDA_PKG_VERSION \
        cuda-nvtx-$CUDA_PKG_VERSION && \
    rm -rf /var/cache/yum/*

###
### https://gitlab.com/nvidia/cuda/raw/centos6/10.0/devel/Dockerfile
###

RUN yum install -y \
        cuda-libraries-dev-$CUDA_PKG_VERSION \
        cuda-nvml-dev-$CUDA_PKG_VERSION \
        cuda-minimal-build-$CUDA_PKG_VERSION \
        cuda-command-line-tools-$CUDA_PKG_VERSION && \
    rm -rf /var/cache/yum/*

ENV LIBRARY_PATH /usr/local/cuda/lib64/stubs

###
### https://gitlab.com/nvidia/cuda/raw/centos6/10.0/devel/cudnn7/Dockerfile
###

ENV CUDNN_VERSION 7.3.1.20
LABEL com.nvidia.cudnn.version="${CUDNN_VERSION}"

# cuDNN license: https://developer.nvidia.com/cudnn/license_agreement
RUN CUDNN_DOWNLOAD_SUM=4e15a323f2edffa928b4574f696fc0e449a32e6bc35c9ccb03a47af26c2de3fa && \
    curl -fsSL http://developer.download.nvidia.com/compute/redist/cudnn/v7.3.1/cudnn-10.0-linux-x64-v7.3.1.20.tgz -O && \
    echo "$CUDNN_DOWNLOAD_SUM  cudnn-10.0-linux-x64-v7.3.1.20.tgz" | sha256sum -c - && \
    tar --no-same-owner -xzf cudnn-10.0-linux-x64-v7.3.1.20.tgz -C /usr/local && \
    rm cudnn-10.0-linux-x64-v7.3.1.20.tgz && \
    ldconfig