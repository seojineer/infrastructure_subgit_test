#!/bin/bash

function get_project_dir() {
	PROJECT_SHA=`echo -n $GITLAB_PROJECT_ID | sha256sum`	

}

function usage() {
	echo "Usage: $0 "
}

if $# -lt 2; then
	usage
	exit 1;
fi

while getopts ":p:u:r:" opt; do
	case $opt in
		p) GITLAB_PROJECT_ID="$OPTARG"
		;;
		u) SVN_SERVER_URL="$OPTARG"
		;;
		r) SVN_REPO="$OPTARG"
		;;
		*) usage
		exit 1
		;;
	esac
done

