#!/bin/bash
# HISAT2 alignment of unzipped .fastq files in folder.

# USAGE: parAlign.sh <RNA-seq dir>

module load hisat2

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

# # Unzip fastq files keeping original
# echo "Decompressing fastq files"
# # gunzip -k *.fastq.gz  # -k argument only works for versions >1.6

# for file in *.fastq.gz; do
# 	echo $file
# 	zcat "$file" > "${file%.*}"
# done

# Loop over each .fastq file
for file in *.fastq.gz; do
	echo "Aligning: " $file
	bsub -J "HISAT2" \
		-P $account \
		-q alloc \
		-W 2:00 \
		-R "rusage[mem=10000]" \
		-n 4 \
		-e logs/error.%J \
		-o logs/output.%J \
		hisat2 -p 4 \
			--dta \
			-x $index \
			-q $file \
			-S align/${file%.*}.sam
done

# Cleanup of decompressed fastq files
# rm *.fastq
