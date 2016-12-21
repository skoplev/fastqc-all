#!/bin/bash

# Change directory to data projects folder
cd ~/DataProjects/phospholamban-cardiomyocytes/RNA-seq/ribo-zero

# HISAT2 index basename
index=~/DataBases/HISAT2/index/grch38_snp_tran/genome_snp_tran

mkdir align
# mkdir temp-unzipped

# Unzip fastq files keeping original
echo "Decompressing fastq files"
gunzip -k *.fastq.gz

# Loop over each .fastq.gz file
for file in *.fastq; do
	echo "Aligning: " $file
	hisat2 -p 6 \
		--dta \
		-x $index \
		-q $file \
		-S align/${file%.*}.sam
done

# Cleanup of decompressed fastq files
rm *.fastq

# Convert SAM to BAM files, also sorts based on genomic coordinates
cd align
mkdir bam
for file in *.sam; do
	echo "Converting $file"
	samtools sort -@ 8 \
		-o bam/${file%.*}.bam \
		$file
done

# Cleanup sam files, which can be very large and contain the same information as the sorted bam files
rm *.sam
cd ..