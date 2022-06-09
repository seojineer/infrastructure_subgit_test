#!/bin/bash

echo "Run svn multi user commit test"

for (( i=1;i<6;i++));
do
	echo $i
	#Usage: ./git_seq.sh -a {GIT_REPO_DIR} -c {CNT}
	echo "./git_seq.sh -a /home/seojikim/work/ci_cd/git/test_repo_$i -c 1 | tee -a git_multi/fadu$i.log &"
	./git_seq.sh -a /home/seojikim/work/ci_cd/git/test_repo_$i -c 1 | tee -a git_multi/fadu$i.log &
	sleep 10
	
done
