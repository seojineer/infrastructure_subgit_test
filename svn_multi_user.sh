#!/bin/bash

echo "Run svn multi user commit test"

function usage() {
	echo "Usage: $0 {SVN_REPO_DIR} {SVN_REPO_NAME}"
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
	# svn 5 user commit
	echo "./svn_seq.sh -a $SVN_REPO_DIR/${SVN_REPO_NAME}_$i -c 1 -u fadu$i -p fadu$i -f true &"
	./svn_seq.sh -a $SVN_REPO_DIR/${SVN_REPO_NAME}_$i -c 1 -u fadu$i -p fadu$i -f true &
	sleep 10
	
done
