#!/bin/bash

PWD=`pwd`
#SVN_REPO_DIR=/user/seojikim/work/svn_repo
#SVN_REPO_DIR=/user/seojikim/work/test_repo
#SVN_USER=fadu1
#SVN_PW=fadu1
#SEQ_NUM=50

function svn_sequential_commit_1user_diff_file() {
	cd $SVN_REPO_DIR
	echo "[SVN] sequential commit test - 1 user"
	echo "--------------------------------------------------"
	svn up
	
	if [ ! -d trunk/svn_sequential3 ]; then
		echo "mkdir svn_sequential"
		svn up
		mkdir -p trunk/svn_sequential3
		svn add trunk/svn_sequential3
		svn commit --username $SVN_USER --password $SVN_PW -m "[svn] add svn_sequential"
	fi

	for ((i=1;i<$SEQ_NUM+1;i++));
	do
		sleep 5
		echo "[SVN] sequential commit test $i - 1 user - diff file"
		echo "--------------------------------------------------"
		svn up
		touch trunk/svn_sequential3/testfile$i
		svn add trunk/svn_sequential3/testfile$i
		svn commit --username $SVN_USER --password $SVN_PW -m "[svn] sequential commit test $i"
	done
	
	cd $PWD
}

function svn_sequential_commit_1user_same_file() {
	cd $SVN_REPO_DIR
	echo "[SVN] sequential commit test - 1 user - same file"
	echo "--------------------------------------------------"

	for ((i=1;i<$SEQ_NUM+1;i++));
	do
		#sleep 5
		echo "[SVN commit test $i]"
		echo "--------------------------------------------------"
		svn up
		echo "add by svn - $i" >> trunk/git_svn_sequential/testfile
		svn add trunk/git_svn_sequential/testfile
		svn commit --username $SVN_USER --password $SVN_PW -m "[svn] sequential commit test $i - 1 user - same file"
	done
	echo "--------------------------------------------------"
	
	cd $PWD
}

function usage() {
	echo "Usage: $0 -a {GIT_REPO_DIR} -c {CNT} -u {SVN_USER} -p {SVN_PW}"
}

if [ $# -lt 2 ]; then
	usage
	exit 1
fi
while getopts ":a:u:p:c:" opt; do
	case $opt in
		a) SVN_REPO_DIR="$OPTARG"
		;;
		u) SVN_USER="$OPTARG"
		;;
		p) SVN_PW="$OPTARG"
		;;
		c) SEQ_NUM="$OPTARG"
		;;
		*) usage
		exit 1
		;;
	esac
done
echo $SVN_REPO_DIR
echo $SVN_USER
echo $SVN_PW
echo $SEQ_NUM

#svn_sequential_commit_1user_diff_file
svn_sequential_commit_1user_same_file
