#!/bin/bash

echo "Todos los kernels instalados"

dpkg -l linux-image-\* | grep ^ii


echo "Todos los kernels no usados"

kernelver=$(uname -r | sed -r 's/-[a-z]+//')
dpkg -l linux-{image,headers}-"[0-9]*" | awk '/ii/{print $2}' | grep -ve $kernelver

echo "Purgando kernels no usados"

sudo apt-get purge $(dpkg -l linux-{image,headers}-"[0-9]*" | awk '/ii/{print $2}' | grep -ve "$(uname -r | sed -r 's/-[a-z]+//')")