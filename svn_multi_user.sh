#!/bin/bash

echo "Run svn multi user commit test"

for (( i=1;i<6;i++));
do
	echo $i
	./svn_seq.sh -a /home/seoji/work/ci_cd/svn/svn_repo_$i -c 5 -u fadu$i -p fadu$i | tee -a fadu$i.log &
	
done
