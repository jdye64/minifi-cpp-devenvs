#!/bin/bash

# Look for environment varialbe MINIFI_CPP_DEVENV_HOME. Default to ~/Desktop/MiNiFiCPPDevEnv
if [ -z "$MINIFI_CPP_DEVENV_HOME" ]; then
    echo "Need to set MINIFI_CPP_DEVENV_HOME"
    exit 1
fi

HOST_DIR="$MINIFI_CPP_DEVENV_HOME"
CONTAINER_DIR="/minifi"

docker run -it -v $HOST_DIR:$CONTAINER_DIR --security-opt seccomp=unconfined jdye64/minifi-devenv:0.0.1-ubuntu bash