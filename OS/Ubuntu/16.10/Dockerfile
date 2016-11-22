FROM ubuntu:16.10
MAINTAINER Jeremy Dyer <jdye64@gmail.com>

ENV MINIFI_HOME=/nifi-minifi-cpp-rel-minifi-cpp-0.0.1
ENV MINIFI_VERSION=0.0.1
ENV MINIFI_SOURCE_URL=https://github.com/apache/nifi-minifi-cpp/archive/rel/minifi-cpp-0.0.1.tar.gz

# apt-get update and then install gcc, g++, and make
RUN apt-get update && apt-get install -y build-essential \
	wget \
	gdb \
	libboost-all-dev \
	libxml2-dev \
	vim \
	uuid-dev \
	libleveldb-dev \
	cmake \
	git

# Perform the build
RUN git clone https://github.com/apache/nifi-minifi-cpp; cd nifi-minifi-cpp; mkdir build; cd build; cmake ..; make