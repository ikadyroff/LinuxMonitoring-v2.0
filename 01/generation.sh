#!bin/bash

generate_folders_name () {
	foldername=$foldername_alphabet
    if [[ ${#foldername} -lt 4 ]]
    then
        f_size=${#foldername}
        diff=$(expr 4 - $f_size)
        for (( j=0; j<$diff; j++ ))
        do
            foldername+=${foldername_alphabet: -1}
        done
    fi
    for (( j=0; j<$i; j++ ))
    do
        foldername+=${foldername_alphabet: -1}
    done
}

create_folder () {
	foldername+="_"
    foldername+=$(date +"%d%m%y")
    sudo mkdir -p $folder_path$foldername
    foldername+="/"
    echo $path$foldername" $(date +'%e.%m.%Y')" >> log_file
    all_folders+="$folder_path$foldername"
    all_folders+=" "
}

generate_folders () {
    touch log_file
    all_folders=""
	foldername_alphabet=$3
	folder_path=$path
    for (( i=0; i<$2; i++ ))
    do
        generate_folders_name $foldername_alphabet $i $path
		create_folder $folder_path$foldername $all_folders
    done
    echo $all_folders
}

generate_filename () {
	filename=$filename_alphabet
    if [[ ${#filename} -lt 4 ]]
    then
        f_size=${#filename}
        diff=$(expr 4 - $f_size)
        for (( j=0; j<$diff; j++ ))
        do
            filename+=${filename_alphabet: -1}
        done
    fi
    for (( j=0; j<$i; j++ ))
    do
        filename+=${filename_alphabet: -1}
    done
    filename+="_"
    filename+=$(date +"%d%m%y")
    filename+="."
    filename+=$extension
    all_files+=$filename
    all_files+=" "
}

create_files () {
	j=$(( $j + 1 ))
    if [[ $j -gt 6 ]]
    then
        folder=$arg
        for file in $all_files
        do
            if [[ $(df / -BM | grep "/" | awk -F"M" '{ print $3 }') -le 1024 ]]
            then
                echo "The script stopped working."
				echo "Only 1 GB of free space remained in the file system (in the / partition)."
                exit 1
            fi
            sudo fallocate -l $size $folder$file
            echo $folder$file" $(date +'%e.%m.%Y') "$size >> log_file
        done
    fi
}

generate_files () {
    size="$(echo $6 | awk -F"kb" '{print $1}')KB"
    filename_alphabet="$(echo $5 | awk -F "." '{print $1}')"
    extension="$(echo $5 | awk -F "." '{print $2}')"
    all_files=""
    for (( i=0; i<$4; i++ ))
    do
		generate_filename $filename_alphabet $i $extension	
    done
    j=0
    for arg in "$@"
    do	
		create_files $arg $all_files $size
    done
}
