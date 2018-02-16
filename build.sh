#!/bin/bash -uex

for TAG in 7.0-cudnn4-devel 7.5-cudnn6-devel 8.0-cudnn7-devel 9.0-cudnn7-devel; do
  docker build -t cuda-manylinux1:${TAG} ${TAG}
done
