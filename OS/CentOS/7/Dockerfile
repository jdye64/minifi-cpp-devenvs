FROM centos:7
MAINTAINER Jeremy Dyer <jdye64@gmail.com>

ENV MINIFI_HOME=/nifi-minifi-cpp-rel-minifi-cpp-0.0.1
ENV MINIFI_VERSION=0.0.1
ENV MINIFI_SOURCE_URL=https://github.com/apache/nifi-minifi-cpp/archive/rel/minifi-cpp-0.0.1.tar.gz

# yum update and then install gcc, g++, and make
RUN yum update && yum group install -y "Development Tools" \
	&& yum install -y wget \
		gdb \
		boost-devel \
		libxml2-devel \
		vim \
	&& wget $MINIFI_SOURCE_URL \
	&& tar -xzvf minifi-cpp-0.0.1.tar.gz \
	&& cd $MINIFI_HOME \
	&& make

# Add the default configuration otherwise starting up will throw a segfault
ADD ./data/flow.yml $MINIFI_HOME/conf