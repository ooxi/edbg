#!/bin/bash
#
# Assumes to be executed with root permissions inside a Fedora
# container.
#
# Expects the repository to be available at $PWD

dnf install -y glibc-locale-source
localedef  --force --inputfile=en_US --charmap=UTF-8 en_US.UTF-8

# Install build dependencies
sudo dnf -y install	\
	git		\
	make		\
	mingw32-gcc

# Driver Development Kit
git clone --branch=v2.5 --depth=1 https://github.com/uic-evl/omicron.git omicron;

# Build environment
export COMPILER='x86_64-w64-mingw32-gcc -Iomicron/external/include/ddk';
export UNAME=Windows;

# Build edbg
find /usr
make clean
make
