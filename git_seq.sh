#!/bin/bash

PWD=`pwd`
LOGFILE=git_seq.log
#GIT_REPO_DIR=/home/seojikim/work/ci_cd/test_repo
#SEQ_NUM=50

function git_sequential_commit_1user_diff_file() {
	echo "[GIT] sequential commit test - 1 user - diff file"
	echo "--------------------------------------------------"
	
	cd $GIT_REPO_DIR
	git pull --rebase origin master

	if [ ! -d git_sequential ]; then
		echo "mkdir git_sequential"
		mkdir git_sequential
		touch git_sequential/testfile
		git add git_sequential
		git commit -m "[git] sequential commit test initial"
		git push origin master
	fi

	for ((i=1;i<$SEQ_NUM+1;i++));
	do
		sleep 5
		echo "[GIT] sequential commit test $i - 1 user - diff file"
		echo "--------------------------------------------------"
		git pull --rebase  origin master
		touch git_sequential/testfile$i
		git add git_sequential/testfile$i
		git commit -m "[git] sequential commit test $i"
		git push origin master
	done
	echo "--------------------------------------------------"
	
	cd $PWD
}

function git_sequential_commit_1user_same_file() {
	echo "[GIT] sequential commit test - 1 user - same file"
	echo "--------------------------------------------------"

	cd $GIT_REPO_DIR
	git pull --rebase origin master

	if [ ! -d git_svn_sequential ]; then
		echo "mkdir git_svn_sequential"
		mkdir git_svn_sequential
		touch git_svn_sequential/testfile
		git add git_svn_sequential
		git commit -m "[git] sequential commit test initial"
		git push origin master
	fi
	
	for ((i=1;i<$SEQ_NUM+1;i++));
	do
		#sleep 5
		echo "[GIT] sequential commit test $i - 1 user - same file"
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

if [ $# -lt 3 ]; then
	usage
	exit 1
fi
while getopts ":a:c:f:" opt; do
	case $opt in
		a) GIT_REPO_DIR="$OPTARG"
		;;
		c) SEQ_NUM="$OPTARG"
		;;
		f) SAME_FILE="$OPTARG"
		;;
		*) usage
		exit 1
		;;
	esac
done
echo $SAME_FILE

if [ "$SAME_FILE" == "true" ] || [ "$SAME_FILE" == "True" ]; then
	git_sequential_commit_1user_same_file
else
	git_sequential_commit_1user_diff_file
fi
