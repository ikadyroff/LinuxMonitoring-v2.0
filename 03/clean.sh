#!/bin/bash

clean_by_logfile () {
	logs=$(cat ../02/log_file | awk '{print $1}')
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
            sudo rm -cached $i
        fi
    done
}

clean_by_mask () {
    read -p "Enter mask (format: foldername_160323): " mask
    symbols=$(echo $mask | awk -F"_" '{ print $1 }')
    date=$(echo $mask | awk -F"_" '{ print $2 }')
    sudo rm -rf $(find / -type f -name "*$symbols*$date" 2>/dev/null)
    sudo rm -rf $(find / -type d -name "*$symbols*$date" 2>/dev/null)
}

if [[ $1 -eq "1" ]]; then
	if [[ -e $"../02/log_file" ]]
	then
		clean_by_logfile
	else
		echo "log file is missing. Need to create a log file."
		exit 1
	fi
fi

if [[ $1 -eq "2" ]]; then
	clean_by_date 
fi

if [[ $1 -eq "3" ]]; then
	clean_by_mask
fi

