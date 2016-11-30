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

printf "\n\n"
echo "============== Apache MiNiFi CPP Developer Framework =============="
echo "The Apache NiFi and MiNiFi projects and logos are copyright of the Apache Software Foundation"
printf "\n\n"

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

	# Remove the previous "compile" directory that would contain any previous compilation run statuses
	rm -rf $MINIFI_CPP_DEVENV_HOME/compile
	mkdir $MINIFI_CPP_DEVENV_HOME/compile

	# Locate all Operating Systems that the current code should be compiled against.
	for f in $PROJ_HOME/OS/*/*/DockerImage.txt
	do
		DOCKER_IMAGE="$(cat $f)"
		echo "Docker Image $DOCKER_IMAGE"
		CONTAINER_ID=$(docker run -it -d -v $MINIFI_CPP_DEVENV_HOME:$CONTAINER_DIR $DOCKER_IMAGE)
		docker cp ./scripts/compileMinifiCPP.sh $CONTAINER_ID:/
		docker exec -it $CONTAINER_ID /compileMinifiCPP.sh $DOCKER_IMAGE
		docker kill $CONTAINER_ID
	done

	# Now lets examine all the files in the $MINIFI_CPP_DEVENV_HOME/compile directory and make sure they are all "PASS" and not "FAIL"
	ALL_PASS=$true
	printf "\n\n"
	for f in $MINIFI_CPP_DEVENV_HOME/compile/*
	do
		COMPILE_STATUS="$(cat $f)"
		if [ "$COMPILE_STATUS" = "FAIL" ]; then
			echo "$f - FAIL"
		else
			echo "$f - PASS"
		fi
	done
}


# Starts a Docker container that is already setup to build minifi-cpp and attaches to it
# with the proper mounts to the local source code so that a developer can code on their host
# OS and then build the code inside the running docker container.
function openDevBuildEnvironment() {
	DOCKER_IMAGE="$(cat $PROJ_HOME/OS/Ubuntu/16.10/DockerImage.txt)"
	echo "Starting docker development container: $DOCKER_IMAGE"
	CONTAINER_ID=$(docker run -it -v $MINIFI_CPP_DEVENV_HOME:$CONTAINER_DIR $DOCKER_IMAGE bash)
}


# Loop through the commandline inquiry loop
while true; do
	printf "\n"
	printf "1 - Validate CPP build against all available Docker images\n"
	printf "2 - Open dev build environment\n"
	printf "q - quit\n"
	printf "\n"
	read -p "Option: " option
	case $option in
		[1]* ) validateBuildAgainstAllOperatingSystems;;
		[2]* ) openDevBuildEnvironment;;
		[qQ]* ) exit;;
	esac
done

echo "Exiting MiNiFi CPP Developer tool. GoodBye"
