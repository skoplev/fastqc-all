#!/bin/bash

# Unzip all fastq.gz files in folder using LFS jobs.
# Keeps original fastq.gz files.
# USAGE: parDecompress.sh <dir>

account="acc_STARNET"

data_dir=$1
if [[ -n $data_dir ]]; then
	cd $data_dir  # otherwise use current working directory
fi

echo "Decompressing fastq files"
# Unzip fastq files keeping original
# gunzip -k *.fastq.gz  # -k argument only works for versions >1.6

# Unzip fastq files keeping original
for file in *.fastq.gz; do
	echo $file
	gunzip -c *.fastq.gz > "${file%.*}"
done

