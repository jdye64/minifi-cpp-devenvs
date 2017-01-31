FROM centos:7.2.1511
MAINTAINER Jeremy Dyer <jdye64@gmail.com>

# minifi-cpp build
RUN yum install -y git
RUN yum install -y wget
RUN yum install -y epel-release
RUN yum groupinstall -y 'Development Tools'
RUN yum install -y cmake
RUN yum install -y boost-devel boost-static libxml2-static libxml2-devel libuuid-devel leveldb-devel

RUN git clone https://github.com/apache/nifi-minifi-cpp.git
ADD deps/patch.cmake /nifi-minifi-cpp
RUN cd nifi-minifi-cpp && git apply patch.cmake