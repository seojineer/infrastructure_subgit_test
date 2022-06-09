#!/bin/bash

echo "Run svn multi user commit test"

function usage() {
	echo "Usage: $0 {SVN_REPO_DIR_PATH} {SVN_REPO_NAME}"
}

if [ $# -lt 2 ]; then
	usage
	exit 1
fi
SVN_REPO_DIR=$1
SVN_REPO_NAME=$2

for (( i=1;i<6;i++));
do
	echo $i
	#Usage: ./git_seq.sh -a {GIT_REPO_DIR} -c {CNT} -s {SAME_FILE: true/false}
	echo "./git_seq.sh -a ${SVN_REPO_DIR}/${SVN_REPO_NAME}_$i -c 1 -f true &"
	./git_seq.sh -a ${SVN_REPO_DIR}/${SVN_REPO_NAME}_$i -c 1 -f true &
	sleep 10
	
done
