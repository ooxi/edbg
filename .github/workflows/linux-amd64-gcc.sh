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
	gcc		\
	make		\
	libudev-devel

# Build environment
export CC=gcc

# Build edbg
make clean
make
