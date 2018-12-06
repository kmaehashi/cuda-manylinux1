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
  TAG="${CUDA}-cudnn${CUDNN}-devel"
  pushd "${TAG}"
  if [ "${CUDA}" != "7.0" ]; then
    ../generate.py --os centos6 --cuda "${CUDA}" --cudnn "${CUDNN}" --variant devel --base quay.io/pypa/manylinux1_x86_64
  fi
  docker build -t "cuda-manylinux1:${TAG}" .
  popd
done
