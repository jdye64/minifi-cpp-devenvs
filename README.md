# Apache MiNiFi CPP Development Environments

This project aims to allow Apache NiFi CPP developers a much more convenient way of testing their code against several different OS and versions. The project is driven entirely off of Docker and utilizes your local installation. Details on installing and configuring Docker are out of scope here.

The ideal way to use this project is to download a local copy of the Apache MiNiFi CPP source code from GitHub using something like ```git clone https://github.com/apache/nifi-minifi-cpp.git``` to your local machine and then setting the value of the environment variable ```MINIFI_CPP_DEVENV_HOME``` to that folder location. Once you set this environment variable you will be able to use the ```{OS}/DockerRun.sh``` script that will open a bash terminal for you in the desired OS with the Apache MiNiFi source code that you just checked out from Github at /minifi. At this point you can continue the development of Apache MiNiFi CPP by using tools like gdb and make on the Docker container side and yet still continue to use a IDE like Sublime on your host machine by editing the files in the location that you checked out the Apache MiNiFi project into.

## Running

This project is dependent on Docker being installed on your local machine. The only script that should be directly used in this project is ```./dev.sh``` this script will provide you with a list of options that can be performed on the Docker images contained within this project such as building your local source code against every Operating System that is defined in the Docker images.