#!bin/bash

if [[ $# != 1 ]]
then
    echo "Wrong number of arguments! Should be one."
    exit 1
fi

if [[ $1 -lt 1 || $1 -gt 3 ]]
then
	echo "Wrong agmument must. be '1', '2' or '3'."
	exit 1
fi
