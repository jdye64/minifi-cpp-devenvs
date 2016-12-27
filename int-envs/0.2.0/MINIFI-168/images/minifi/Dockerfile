FROM jdye64/minifi-cpp-devenvs:0.1.0-ubuntu-16.10
MAINTAINER Jeremy Dyer <jdye64@gmail.com>

ENV MINIFI_SOURCE_HOME=/nifi-minifi-cpp
ENV MINIFI_PACKAGE_BINARY_NAME=nifi-minifi-cpp-0.2.0-bin.tar.gz
ENV MINIFI_HOME=/nifi-minifi-cpp-0.2.0

# Checkout the PR https://github.com/apache/nifi-minifi-cpp/pull/31
RUN git clone https://github.com/apache/nifi-minifi-cpp.git && cd nifi-minifi-cpp && git fetch origin pull/31/head:MINIFI-168 && git checkout MINIFI-168

# Build the code from the branch
RUN cd $MINIFI_SOURCE_HOME && mkdir build && cd build && cmake .. && make && make package && mv /nifi-minifi-cpp/build/$MINIFI_PACKAGE_BINARY_NAME / && cd / && tar -xzvf $MINIFI_PACKAGE_BINARY_NAME

# Clean up to make the image a little smaller
RUN rm -rf nifi-minifi-cpp

# Make /tmp/getfile directory
RUN mkdir /tmp/getfile && touch /tmp/getfile/something.txt

# Setup the MiNiFi workflow that will be tested
ADD deps/config.yml $MINIFI_HOME/conf

# Startup MiNiFi
CMD $MINIFI_HOME/bin/minifi.sh run