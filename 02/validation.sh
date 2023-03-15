#!/bin/bash

if [[ $# -ne 3 ]]
then
    echo "Error! should be 3 arguments."
    exit 1
fi

if ! [[ $1 =~ ^[a-zA-Z]{1,7}$ ]]
then
    echo "1-st arg: Expected list of English alphabet letters for folder names."
	echo "Maximum 7 characters."
    exit 1
fi

if ! [[ $2 =~ ^[a-zA-Z]{1,7}[.][a-zA-Z]{1,3}$ ]]
then
    echo "2-nd arg: Expected list of English alphabet lettesr for filenames and extensions."
	echo "Maximum 7 characters for filename, maximum 3 characters for extension."
    exit 1
fi

if ! [[ $3 =~ ^[1-9][0-9]?[0]?Mb$ ]]
then
    echo "3-d arg: Expected file size (in megabytes, but not more than 100Mb)."
    exit 1
fi