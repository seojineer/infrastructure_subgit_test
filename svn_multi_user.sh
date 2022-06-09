#!/bin/bash

echo "Run svn multi user commit test"
SVN_REPO_DIR=$1
SVN_REPO_NAME=$2
echo $SVN_REPO_DIR
echo $SVN_REPO_NAME

for (( i=1;i<6;i++));
do
	echo $i
	# svn 5 user commit
	echo "./svn_seq.sh -a $SVN_REPO_DIR/${SVN_REPO_NAME}_$i -c 1 -u fadu$i -p fadu$i | tee -a svn_multi/fadu$i.log &"
	./svn_seq.sh -a $SVN_REPO_DIR/${SVN_REPO_NAME}_$i -c 1 -u fadu$i -p fadu$i | tee -a svn_multi/fadu$i.log &
	sleep 10
	
done
