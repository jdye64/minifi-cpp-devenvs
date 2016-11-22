FROM centos:7.2.1511
MAINTAINER Jeremy Dyer <jdye64@gmail.com>

# Java & Generic setup
RUN yum install -y java-1.8.0-openjdk-devel wget unzip net-tools
RUN echo "export JAVA_HOME=/usr/lib/jvm/java" >> /root/.bashrc

# maven setup
ARG MAVEN_URL=https://archive.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
ARG MAVEN_VER=apache-maven-3.3.9
RUN wget ${MAVEN_URL} -O /maven.tgz && tar -xzvf /maven.tgz && mv ${MAVEN_VER} /maven

# minifi-cpp build
RUN yum install -y git 
RUN yum install -y epel-release
RUN yum groupinstall -y 'Development Tools'
RUN yum install -y cmake
RUN yum install -y boost-devel libxml2-devel libuuid-devel leveldb-devel
CMD export PATH=$PATH:/maven/bin