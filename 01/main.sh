#!/bin/bash

source ./validation.sh
source ./generation.sh

folders=$(generate_folders $path $2 $3)
generate_files $path $2 $3 $4 $5 $6 $folders