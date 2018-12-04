FROM quay.io/pypa/manylinux1_x86_64

USER root

###
### Runtime: hand-written based on `7.5-cudnn6-devel`
###

RUN NVIDIA_GPGKEY_SUM=d1be581509378368edeec8c1eb2958702feedf3bc3d17011adbf24efacce4ab5 && \
    curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/rhel6/x86_64/7fa2af80.pub | sed '/^Version/d' > /etc/pki/rpm-gpg/RPM-GPG-KEY-NVIDIA && \
    echo "$NVIDIA_GPGKEY_SUM  /etc/pki/rpm-gpg/RPM-GPG-KEY-NVIDIA" | sha256sum -c -

COPY cuda.repo /etc/yum.repos.d/cuda.repo

ENV CUDA_VERSION 7.0.28

ENV CUDA_PKG_VERSION 7-0-7.0-28
RUN yum install -y \
        cuda-nvrtc-$CUDA_PKG_VERSION \
        cuda-cusolver-$CUDA_PKG_VERSION \
        cuda-cublas-$CUDA_PKG_VERSION \
        cuda-cufft-$CUDA_PKG_VERSION \
        cuda-curand-$CUDA_PKG_VERSION \
        cuda-cusparse-$CUDA_PKG_VERSION \
        cuda-npp-$CUDA_PKG_VERSION \
        cuda-cudart-$CUDA_PKG_VERSION && \
    ln -s cuda-7.0 /usr/local/cuda && \
    rm -rf /var/cache/yum/*

RUN echo "/usr/local/cuda/lib64" >> /etc/ld.so.conf.d/cuda.conf && \
    ldconfig

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
ENV NVIDIA_REQUIRE_CUDA "cuda>=7.0"

###
### Devel: hand-written based on `7.5-cudnn6-devel`
###

RUN yum install -y \
        cuda-core-$CUDA_PKG_VERSION \
        cuda-misc-headers-$CUDA_PKG_VERSION \
        cuda-command-line-tools-$CUDA_PKG_VERSION \
        cuda-license-$CUDA_PKG_VERSION \
        cuda-nvrtc-dev-$CUDA_PKG_VERSION \
        cuda-cusolver-dev-$CUDA_PKG_VERSION \
        cuda-cublas-dev-$CUDA_PKG_VERSION \
        cuda-cufft-dev-$CUDA_PKG_VERSION \
        cuda-curand-dev-$CUDA_PKG_VERSION \
        cuda-cusparse-dev-$CUDA_PKG_VERSION \
        cuda-npp-dev-$CUDA_PKG_VERSION \
        cuda-cudart-dev-$CUDA_PKG_VERSION \
        cuda-driver-dev-$CUDA_PKG_VERSION \
        gcc-c++ \
        yum-utils && \
    rm -rf /var/cache/yum/*

RUN mkdir /tmp/gpu-deployment-kit && cd /tmp/gpu-deployment-kit && \
    rpm2cpio $(repoquery --location  gpu-deployment-kit) | cpio -id && \
    mv usr/include/nvidia/gdk/* /usr/local/cuda/include && \
    mv usr/src/gdk/nvml/lib/* /usr/local/cuda/lib64/stubs && \
    rm -rf /tmp/gpu-deployment-kit* && \
    rm -rf /var/cache/yum/*

ENV LIBRARY_PATH /usr/local/cuda/lib64/stubs

###
### cuDNN: hand-written based on `7.5-cudnn6-devel`
###

ENV CUDNN_VERSION 4.0.8
LABEL com.nvidia.cudnn.version="${CUDNN_VERSION}"

# cuDNN license: https://developer.nvidia.com/cudnn/license_agreement
RUN CUDNN_DOWNLOAD_SUM=cd091763d5889f0efff1fbda83bade191f530743a212c6b0ecc2a64d64d94405 && \
    curl -fsSL http://developer.download.nvidia.com/compute/redist/cudnn/v4/cudnn-7.0-linux-x64-v4.0-prod.tgz -O && \
    echo "$CUDNN_DOWNLOAD_SUM  cudnn-7.0-linux-x64-v4.0-prod.tgz" | sha256sum -c - && \
    tar --no-same-owner -xzf cudnn-7.0-linux-x64-v4.0-prod.tgz -C /usr/local && \
    rm cudnn-7.0-linux-x64-v4.0-prod.tgz && \
    ldconfig
