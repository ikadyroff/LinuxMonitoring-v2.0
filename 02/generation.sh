#!/bin/bash

generate_foldername () {
    if [[ ${#foldername_alphabet} -lt 5 ]]
    then
        for (( i=${#foldername_alphabet}; i<5; i++ ))
        do
            foldername_alphabet+=${1: -1}
        done
    fi
}

generate () {
    touch log_file
    start_path=$(pwd)
    start_time=$(date +'%Y.%m.%d %H:%M:%S')
    start_sec=$(date +'%s%N')
    echo "Script started at $start_time" >> log_file
    echo "Script started at $start_time"
    foldername_alphabet=$1
    creation_date="$(date +"%d%m%y")"
	generate_foldername $foldername_alphabet
	foldername=$foldername_alphabet
    dirs_n=$(echo $(( 1 + $RANDOM % 1000 )))

    for (( i=0; i<$dirs_n; i++ ))
    do
        random_dir="$(compgen -d / | shuf -n1)"
        file_n="$(shuf -i 1-50 -n1)"
        if [[ $random_dir == "/bin" || $random_dir == "/sbin" ]]
        then
            dirs_n=$(( $dirs_n + 1 ))
            continue
        fi
        path=$random_dir"/"$foldername"_"$creation_date
        foldername+=${1: -1}
        sudo mkdir -p $path 2>/dev/null
        path+="/"
        echo $path" $(date +'%e.%m.%Y')" >> log_file
		filename=$(echo $2 | awk -F. '{print $1}')
        file_ext=$(echo $2 | awk -F. '{print $2}')
        file_last=${filename: -1}
        if [[ ${#filename} -lt 5 ]]
        then
            for (( j=${#filename}; j<5; j++ ))
            do
                filename+=$file_last
            done
        fi
        for (( j=0; j<$file_n; j++ ))
        do
            if [[ $(df / -BM | grep "/" | awk -F"M" '{ print $3 }') -le 1024 ]]
            then
                echo "No available disk space, you have only 1 Gb"
                j=$file_n
                i=$dirs_n
                continue
            fi
            full_name=$filename"_"$creation_date"."$file_ext
            filename+=$file_last
            sudo fallocate -l $3 $path$full_name 2>/dev/null
            echo $path$full_name" $(date +'%e.%m.%Y') "$3 >> log_file
        done
    done

    cd $start_path
    end_time=$(date +'%Y-%m-%d %H:%M:%S')
    end_sec=$(date +'%s%N')
	echo "" >> log_file
    echo "Script finished at $end_time" >> log_file
    echo "Script finished at $end_time"
    total_time=$((( $end_sec - $start_sec ) / 1000000000 ))
    echo "Total script running time: $total_time secconds" >> log_file
	echo "" >> log_file
    echo "Total script running time: $total_time secconds"
}