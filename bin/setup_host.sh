#!/usr/bin/env bash

MEMORY=6144 # 6GB of RAM
STORAGE=80000 # 80GB of disk space
CPUS=4 # Use 4 of the 8 logical cores 

docker-machine rm default -y

docker-machine create \
  -d virtualbox \
  --virtualbox-memory $MEMORY \
  --virtualbox-disk-size $STORAGE \
  --virtualbox-cpu-count $CPUS \
  default
