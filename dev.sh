#!/bin/bash

printf "\n"
cat << "EOF"
                r                
               ain
               rai
              nrain
             rainrai
            nrainrain
           ainrainrain
          rainrainrainr
         ainrainrainrain
        rainrainrainrainr
      ainrainrainrainrainra
    inra nrainrainrainrainrai
  nrain  inrainrainrainrainrain
 rain   nrainrainrainrainrainrai
nrai   inrainrainrainrainrainrain
rai   inrainrainrainrainrainrainr
rain   nrainrainrainrainrainrainr
 rainr  nrainrainrainrainrainrai
  nrain ainrainrainrainrainrain
    rainrainrainrainrainrainr
      rainranirainrainrainr
           ainrainrain
EOF

echo "============== Apache MiNiFi CPP Developer Framework =============="
echo "The Apache NiFi and MiNiFi projects and logos are copyright of the Apache Software Foundation"

pushd `dirname $0` > /dev/null
PROJ_HOME=`pwd`
popd > /dev/null

# Look for environment varialbe MINIFI_CPP_DEVENV_HOME. Default to ~/Desktop/MiNiFiCPPDevEnv
if [ -z "$MINIFI_CPP_DEVENV_HOME" ]; then
    echo "Need to set MINIFI_CPP_DEVENV_HOME"
    exit 1
fi

CONTAINER_DIR="/minifi"

# Tests that the build works against all of the available Docker images
function validateBuildAgainstAllOperatingSystems {
	echo "Validating that the current source code $MINIFI_CPP_DEVENV_HOME builds against all available Docker images"

	# Locate all Operating Systems that the current code should be compiled against.
	for f in $PROJ_HOME/OS/*/*/DockerImage.txt
	do
		echo "File $f"
		DOCKER_IMAGE="$(cat $f)"
		echo "Docker Image $DOCKER_IMAGE"
		docker run -it -v $MINIFI_CPP_DEVENV_HOME:$CONTAINER_DIR $DOCKER_IMAGE make -C /minifi
	done
}


# Loop through the commandline inquiry loop
while true; do
	printf "\n"
	printf "1 - Validate CPP build against all available Docker images\n"
	printf "q - quit\n"
	printf "\n"
	read -p "Option: " option
	case $option in
		[1]* ) validateBuildAgainstAllOperatingSystems;;
		[qQ]* ) exit;;
	esac
done

echo "Exiting MiNiFi CPP Developer tool. GoodBye"
