FROM jdye64/docker-hwx:nifi-1.1.0
MAINTAINER Jeremy Dyer <jdye64@gmail.com>

# Add the custom NiFi configurations and dependencies for this run
ADD deps/nifi.properties $NIFI_HOME/conf
ADD deps/flow.xml.gz $NIFI_HOME/conf