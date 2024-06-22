#!/bin/bash

# Define the directory where the files will be downloaded
dir="./clash"

# Create the directory if it doesn't exist
mkdir -p $dir

# Open the file clash_rules.txt and read line by line
while IFS= read -r url
do
    # Use wget to download the file from the URL and save it in the defined directory
    wget -P $dir "$url"
done < clash_rules.txt
