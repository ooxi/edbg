#!/bin/bash
#
# Assumes to be executed with root permissions inside a Fedora
# container.
#
# Expects the following directories to be provided from the host
#  - /source: read-only repository
#  - /target: read-write directory where the built binary should be
#             placed

dnf install -y glibc-locale-source
localedef  --force --inputfile=en_US --charmap=UTF-8 en_US.UTF-8

# Install build dependencies
sudo dnf -y install	\
	git		\
	make		\
	mingw64-gcc

# Driver Development Kit
git clone --branch=v2.5 --depth=1 https://github.com/uic-evl/omicron.git omicron;

# Build environment
export COMPILER='x86_64-w64-mingw32-gcc -Iomicron/external/include/ddk';
export UNAME=Windows;

# Build edbg
make clean
make
