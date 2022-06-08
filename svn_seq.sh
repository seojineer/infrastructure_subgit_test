#!/bin/bash

PWD=`pwd`
SVN_REPO_DIR=/user/seojikim/work/svn_repo
#SVN_REPO_DIR=/user/seojikim/work/test_repo
SVN_USER=fadu1
SVN_PW=fadu1
SEQ_NUM=50

function svn_sequential_commit_1user_diff_file() {
	cd $SVN_REPO_DIR
	echo "[SVN] sequential commit test - 1 user"
	
	if [ ! -d trunk/svn_sequential ]; then
		echo "mkdir svn_sequential"
		svn up
		mkdir -p trunk/svn_sequential
		svn add trunk/svn_sequential
		svn commit --username $SVN_USER --password $SVN_PW -m "[svn] add svn_sequential"
	fi

	for ((i=1;i<$SEQ_NUM+1;i++));
	do
		echo $i
		svn up
		touch trunk/svn_sequential/testfile$i
		svn add trunk/svn_sequential/testfile$i
		svn commit --username $SVN_USER --password $SVN_PW -m "[svn] sequential commit test $i"
	done
	
	cd $PWD
}

function svn_sequential_commit_1user_same_file() {
	cd $SVN_REPO_DIR
	echo "[SVN] sequential commit test - 1 user - same file"

	for ((i=1;i<$SEQ_NUM+1;i++));
	do
		sleep 240
		echo $i
		svn up
		echo "add by svn - $i" >> trunk/git_svn_sequential/testfile
		svn add trunk/git_svn_sequential/testfile
		svn commit --username $SVN_USER --password $SVN_PW -m "[svn] sequential commit test $i - 1 user - same file"
	done
	
	cd $PWD
}

#svn_sequential_commit_1user_diff_file
svn_sequential_commit_1user_same_file
