#!/bin/bash

clean_by_logfile () {
	logs=$(cat log_file | awk '{print $1}')
	for i in $logs
    do
        if [[ ${i: 0:1 } == "/" ]]
        then
            sudo rm -rf $i
        fi
    done
}

clean_by_date () {
    echo "Enter the date and time (format: YYYY-MM-DD HH:MM)"
    read -p "Write start date and time: " start
    echo "Enter the date and time (format: YYYY-MM-DD HH:MM)"
    read -p "Write end date and time: " end
    files=`sudo find / -newermt "$start" ! -newermt "$end"  2>/dev/null | sort -r`
    for i in $files
    do
        last=$(echo $i | awk -F"/" '{ print $NF }')
        if [[ $last =~ "." ]]
        then
            sudo rm -rf $i
        fi
    done
}



if [[ $1 -eq "1" ]]; then
	if [[ -e $"log_file" ]]
	then
		clean_by_logfile
	else
		echo "log file is missing. Add a log file to this directory."
		exit 1
	fi
fi

if [[ $1 -eq "2" ]]; then
	clean_by_date $1
fi

if [[ $1 -eq "3" ]]; then
	clean_by_mask
fi

