# FROM centos:6
FROM quay.io/pypa/manylinux1_x86_64

USER root

###
### Modified based on:
### https://gitlab.com/nvidia/cuda/raw/centos6/10.0/base/Dockerfile
###

ENV CUDA_VERSION 10.0.130

ENV CUDA_PKG_VERSION 10-0-$CUDA_VERSION-1

ENV PATH /usr/local/cuda/bin:${PATH}

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
ENV NVIDIA_REQUIRE_CUDA "cuda>=10.0 brand=tesla,driver>=384,driver<385"

###
### Run `runfile` installer
###

RUN CUDA_DRIVER_VERSION=410.48 && \
    CUDA_RUNFILE_INSTALLER=/tmp/installer.run && \
    curl -o "${CUDA_RUNFILE_INSTALLER}" -L "https://developer.nvidia.com/compute/cuda/10.0/Prod/local_installers/cuda_${CUDA_VERSION}_${CUDA_DRIVER_VERSION}_linux" && \
    sh "${CUDA_RUNFILE_INSTALLER}" --silent --toolkit && \
    rm "${CUDA_RUNFILE_INSTALLER}" && \
    echo "/usr/local/cuda/lib64" > /etc/ld.so.conf.d/cuda.conf && \
    ldconfig

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