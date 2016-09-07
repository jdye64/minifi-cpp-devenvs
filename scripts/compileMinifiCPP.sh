#!/bin/bash
FILE_IND_DIR="/minifi/compile"
cd /minifi && make clean && make

IFS=\/ # delimit on _
set -f # disable the glob part
FILE_PARTS=$1 # invoke the split+glob operator

if [ $? != 0 ]; then
    echo "FAIL" > $FILE_IND_DIR/${FILE_PARTS[1]}
else
	# Touch a file to show that this compilation passed. Remember this Docker container has a mount to the local host so 
	# ultimately we will be writing the file there.
	echo "PASS" > $FILE_IND_DIR/${FILE_PARTS[1]}
fi