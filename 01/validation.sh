#!bin/bash

if [[ $# -ne 6 ]]
then
    echo "Invalid number of arguments"
    exit 1
fi

if  [[ ${$1: 0:1} != "/" ]] || ! [[ -d $1 ]]
then
    echo "1-th arg: Invalid path or path is not absolute!"
    exit 1
fi

reg1='^[1-9][0-9]+?$'
if ! [[ $2 =~ $reg1 ]]
then
    echo "2-nd arg: Argument is not an integer or less then 1!"
    exit 1
fi

reg2='^[a-zA-Z]{1,7}$'
if ! [[ $3 =~ $reg2 ]]
then
    echo "3-rd arg: Arg consist not only from leters or longer than 7 characters!"
    exit 1
fi

if ! [[ $4 =~ $reg1 ]]
then
    echo "4-th arg: argument is not an integer or less then 1"
    exit 1
fi

reg3='^[a-zA-Z]{1,7}[.][a-zA-Z]{1,3}$'
if ! [[ $5 =~ $reg3 ]]
then
    echo "5-th arg: No more than 7 characters for a name, no more than 3 characters for an acquisition!"
fi

reg4='^[1-9][0-9]?[0]?kb$'
if ! [[ $6 =~ $reg4 ]]
then
    echo "6-th arg: The file size must be in Kb, but not more than 100kb"
    exit 1
fi
