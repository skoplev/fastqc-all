#!/bin/bash

module load samtools

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