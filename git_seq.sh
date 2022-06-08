#!/bin/bash

PWD=`pwd`
LOGFILE=git_seq.log
#GIT_REPO_DIR=/home/seojikim/work/ci_cd/testtest
#GIT_REPO_DIR=/home/seojikim/work/ci_cd/test_repo
#SEQ_NUM=50

function git_sequential_commit_1user_diff_file() {
	cd $GIT_REPO_DIR
	echo "[GIT] sequential commit test - 1 user"
	echo "--------------------------------------------------"
	
	if [ ! -d git_sequential3 ]; then
		echo "mkdir git_sequential"
		mkdir git_sequential3
	fi

	for ((i=1;i<$SEQ_NUM+1;i++));
	do
		sleep 5
		echo "[GIT] sequential commit test $i - 1 user - diff file"
		echo "--------------------------------------------------"
		git pull --rebase  origin master
		touch git_sequential3/testfile$i
		git add git_sequential3/testfile$i
		git commit -m "[git] sequential commit test $i"
		git push origin master
	done
	echo "--------------------------------------------------"
	
	cd $PWD
}

function git_sequential_commit_1user_same_file() {
	cd $GIT_REPO_DIR
	echo "[GIT] sequential commit test - 1 user - same file"
	echo "--------------------------------------------------"
	
	for ((i=1;i<$SEQ_NUM+1;i++));
	do
		#sleep 5
		echo "[GIT push test $i]"
		echo "--------------------------------------------------"
		git pull --rebase origin master
		echo "add by git - $i" >> git_svn_sequential/testfile
		git add git_svn_sequential/testfile
		git commit -m "[git] sequential commit test $i - 1 user - same file"
		git push origin master
	done
	echo "--------------------------------------------------"
	
	cd $PWD
}

function usage() {
	echo "Usage: $0 -a {GIT_REPO_DIR} -c {CNT}"
}

if [ $# -lt 2 ]; then
	usage
	exit 1
fi
while getopts ":a:c:" opt; do
	case $opt in
		a) GIT_REPO_DIR="$OPTARG"
		;;
		c) SEQ_NUM="$OPTARG"
		;;
		*) usage
		exit 1
		;;
	esac
done

#git_sequential_commit_1user_diff_file | tee -a ${LOGFILE}
git_sequential_commit_1user_same_file
