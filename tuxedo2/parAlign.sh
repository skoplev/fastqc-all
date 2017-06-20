#!/bin/bash
# HISAT2 alignment 

# parAlign.sh <RNA-seq dir>

# Change directory to data projects folder
data_dir=$1
if [[ -n $data_dir ]]; then
	cd $data_dir  # otherwise use current working directory
fi

# HISAT2 index basename
index=~/links/STARNET/koples01/data_bases/HISAT2/index/grch38_snp_tran/genome_snp_tran
account="acc_STARNET"

mkdir align  # output dir
mkdir logs  # for bsub logs
# mkdir temp-unzipped

# Unzip fastq files keeping original
echo "Decompressing fastq files"
gunzip -k *.fastq.gz

# Loop over each .fastq file
for file in *.fastq; do
	echo "Aligning: " $file
	bsub -J "HISAT2_$file" \
		-P $account \
		-q alloc \
		-W 12:00 \
		-R rusage[mem=4000] \
		-r logs/error.%J \
		-o logs/output.%J \
		hisat2 -p 6 \
			--dta \
			-x $index \
			-q $file \
			-S align/${file%.*}.sam
done
