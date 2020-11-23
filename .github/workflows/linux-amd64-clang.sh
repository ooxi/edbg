#!/bin/bash
#
# Assumes to be executed with root permissions inside a Fedora
# container.
#
# The following directories should be provided from the outside world
#  - /github/workspace: read/write repository checkout

dnf install -y glibc-locale-source
localedef  --force --inputfile=en_US --charmap=UTF-8 en_US.UTF-8

sudo dnf -y install	\
	clang		\
	make		\
	libudev-devel