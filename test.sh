#!/bin/bash -uex

CUDA_CUDNN="\
7.0     4
7.5     6
8.0     7
9.0     7
9.1     7
9.2     7
10.0    7
"

curl -o generate.py "https://raw.githubusercontent.com/kmaehashi/cuda-docker-generator/master/generate.py"
echo "${CUDA_CUDNN}" | while read CUDA CUDNN; do
  [ "${CUDA}" = "" ] && break
  TAG="${CUDA}-cudnn${CUDNN}-devel"
  pushd "${TAG}"
  if [ "${CUDA}" = "7.0" ]; then
    CUDA=7.5
    CUDNN=5
  fi
  python ../generate.py --os centos6 --cuda "${CUDA}" --cudnn "${CUDNN}" --variant devel --base quay.io/pypa/manylinux1_x86_64
  if [ -f "Dockerfile.patch" ]; then
    patch -p0 < ./Dockerfile.patch
  fi
  docker build -t "cuda-manylinux1:${TAG}" .
  popd
done
rm generate.py
