#!/bin/bash
FILE_IND_DIR="/minifi/compile"
cd /minifi && make clean && make

IFS=\/ # delimit on _
set -f # disable the glob part
FILE_PARTS=($1) # invoke the split+glob operator

if [ $? != 0 ]; then
	PART="${FILE_PARTS[1]}"
    echo "FAIL" > "$FILE_IND_DIR/$PART"
else
	# Touch a file to show that this compilation passed. Remember this Docker container has a mount to the local host so 
	# ultimately we will be writing the file there.
	PART="${FILE_PARTS[1]}"
	echo "PASS" > "$FILE_IND_DIR/$PART"
fi