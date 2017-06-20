#!/bin/bash

# 
account="acc_STARNET"

# Parallel gz
module load pigz

# Change directory to data projects folder
data_dir=$1
if [[ -n $data_dir ]]; then
	cd $data_dir  # otherwise use current working directory
fi

bsub -J "unpigz" \
	-P $account \
	-q alloc \
	-W 6:00 \
	-R "rusage[mem=20000]" \
	-n 8 \
	-e logs/error.%J \
	-o logs/output.%J \
	unpigz \k \
		*.fastq.gz

