# FROM centos:6
FROM quay.io/pypa/manylinux1_x86_64

USER root

###
### https://gitlab.com/nvidia/cuda/raw/centos6/9.2/base/Dockerfile
###

RUN NVIDIA_GPGKEY_SUM=d1be581509378368edeec8c1eb2958702feedf3bc3d17011adbf24efacce4ab5 && \
    curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/rhel6/x86_64/7fa2af80.pub | sed '/^Version/d' > /etc/pki/rpm-gpg/RPM-GPG-KEY-NVIDIA && \
    echo "$NVIDIA_GPGKEY_SUM  /etc/pki/rpm-gpg/RPM-GPG-KEY-NVIDIA" | sha256sum -c -

COPY cuda.repo /etc/yum.repos.d/cuda.repo

ENV CUDA_VERSION 9.2.148

ENV CUDA_PKG_VERSION 9-2-$CUDA_VERSION-1
RUN yum install -y \
        cuda-cudart-$CUDA_PKG_VERSION && \
    ln -s cuda-9.2 /usr/local/cuda && \
    rm -rf /var/cache/yum/*

# nvidia-docker 1.0
LABEL com.nvidia.volumes.needed="nvidia_driver"
LABEL com.nvidia.cuda.version="${CUDA_VERSION}"

RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
    echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf

ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
ENV NVIDIA_REQUIRE_CUDA "cuda>=9.2"

###
### https://gitlab.com/nvidia/cuda/raw/centos6/9.2/runtime/Dockerfile
###

RUN yum install -y \
        cuda-libraries-$CUDA_PKG_VERSION \
        cuda-nvtx-$CUDA_PKG_VERSION && \
    rm -rf /var/cache/yum/*

###
### https://gitlab.com/nvidia/cuda/raw/centos6/9.2/devel/Dockerfile
###

RUN yum install -y \
        cuda-libraries-dev-$CUDA_PKG_VERSION \
        cuda-nvml-dev-$CUDA_PKG_VERSION \
        cuda-minimal-build-$CUDA_PKG_VERSION \
        cuda-command-line-tools-$CUDA_PKG_VERSION && \
    rm -rf /var/cache/yum/*

ENV LIBRARY_PATH /usr/local/cuda/lib64/stubs

###
### https://gitlab.com/nvidia/cuda/raw/centos6/9.2/devel/cudnn7/Dockerfile
###

ENV CUDNN_VERSION 7.3.1.20
LABEL com.nvidia.cudnn.version="${CUDNN_VERSION}"

# cuDNN license: https://developer.nvidia.com/cudnn/license_agreement
RUN CUDNN_DOWNLOAD_SUM=aa652e95e66deb2970247fdeb5c5f6ae8b30ab6a35050df1354613acb1da6d05 && \
    curl -fsSL http://developer.download.nvidia.com/compute/redist/cudnn/v7.3.1/cudnn-9.2-linux-x64-v7.3.1.20.tgz -O && \
    echo "$CUDNN_DOWNLOAD_SUM  cudnn-9.2-linux-x64-v7.3.1.20.tgz" | sha256sum -c - && \
    tar --no-same-owner -xzf cudnn-9.2-linux-x64-v7.3.1.20.tgz -C /usr/local && \
    rm cudnn-9.2-linux-x64-v7.3.1.20.tgz && \
    ldconfig