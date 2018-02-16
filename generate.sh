#!/bin/bash -uex

pushd 7.5-cudnn6-devel
curl https://gitlab.com/nvidia/cuda/raw/centos6/7.5/runtime/cuda.repo > cuda.repo
../concat_dockerfiles.py \
    https://gitlab.com/nvidia/cuda/raw/centos6/7.5/runtime/Dockerfile \
    https://gitlab.com/nvidia/cuda/raw/centos6/7.5/devel/Dockerfile \
    https://gitlab.com/nvidia/cuda/raw/centos6/7.5/devel/cudnn6/Dockerfile \
    > Dockerfile
popd

pushd 8.0-cudnn7-devel
curl https://gitlab.com/nvidia/cuda/raw/centos6/8.0/runtime/cuda.repo > cuda.repo
../concat_dockerfiles.py \
    https://gitlab.com/nvidia/cuda/raw/centos6/8.0/runtime/Dockerfile \
    https://gitlab.com/nvidia/cuda/raw/centos6/8.0/devel/Dockerfile \
    https://gitlab.com/nvidia/cuda/raw/centos6/8.0/devel/cudnn7/Dockerfile \
    > Dockerfile
popd

pushd 9.0-cudnn7-devel
curl https://gitlab.com/nvidia/cuda/raw/centos6/9.0/base/cuda.repo > cuda.repo
../concat_dockerfiles.py \
    https://gitlab.com/nvidia/cuda/raw/centos6/9.0/base/Dockerfile \
    https://gitlab.com/nvidia/cuda/raw/centos6/9.0/runtime/Dockerfile \
    https://gitlab.com/nvidia/cuda/raw/centos6/9.0/devel/Dockerfile \
    https://gitlab.com/nvidia/cuda/raw/centos6/9.0/devel/cudnn7/Dockerfile \
    > Dockerfile
popd
