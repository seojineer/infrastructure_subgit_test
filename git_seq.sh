#!/bin/bash

PWD=`pwd`
GIT_REPO_DIR=/home/seojikim/work/ci_cd/testtest
#GIT_REPO_DIR=/home/seojikim/work/ci_cd/test_repo
SEQ_NUM=50

function git_sequential_commit_1user_diff_file() {
	cd $GIT_REPO_DIR
	echo "[GIT] sequential commit test - 1 user"
	
	if [ ! -d git_sequential ]; then
		echo "mkdir git_sequential"
		mkdir git_sequential
	fi

	for ((i=1;i<$SEQ_NUM+1;i++));
	do
		echo $i
		git pull --rebase  origin master
		touch git_sequential/testfile$i
		git add git_sequential/testfile$i
		git commit -m "[git] sequential commit test $i"
		git push origin master
	done
	
	cd $PWD
}

function git_sequential_commit_1user_same_file() {
	cd $GIT_REPO_DIR
	echo "[GIT] sequential commit test - 1 user - same file"
	
	for ((i=1;i<$SEQ_NUM+1;i++));
	do
		sleep 240
		echo $i
		git pull --rebase origin master
		echo "add by git - $i" >> git_svn_sequential/testfile
		git add git_svn_sequential/testfile
		git commit -m "[git] sequential commit test $i - 1 user - same file"
		git push origin master
	done
	
	cd $PWD
}

#git_sequential_commit_1user_diff_file
git_sequential_commit_1user_same_file
