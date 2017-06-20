#!/bin/bash

# Unzip all fastq.gz files in folder using LFS jobs.
# Keeps original fastq.gz files.
# USAGE: parDecompress.sh <dir>


account="acc_STARNET"

data_dir=$1
if [[ -n $data_dir ]]; then
	cd $data_dir  # otherwise use current working directory
fi

	


# Unzip fastq files keeping original
echo "Decompressing fastq files"
mkdir logs
for file in *.fastq.gz; do
	bsub -J "gzip" \
		-P $account \
		-q alloc \
		-W 1:00 \
		-R "rusage[mem=2000]" \
		-n 1 \
		-e logs/error.%J \
		-o logs/output.%J \
		zcat "$file" > "${file%.*}"
done
