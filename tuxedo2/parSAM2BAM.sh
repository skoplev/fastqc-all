#BSUB -J samtools
#BSUB -P acc_STARNET
#BSUB -q alloc
#BSUB -W 12:00
#BSUB -M 8000
#BSUB -n 1
#BSUB -e logs/error.%J
#BSUB -o logs/output.%J

# USAGE:
# bsub -cwd <dir> < tuxedo2/parSAM2BAM.sh

module load samtools

# Convert SAM to BAM files, also sorts based on genomic coordinates
mkdir bam
for file in *.sam; do
	echo "Converting $file"
	samtools sort -@ 8 \
		-o bam/${file%.*}.bam \
		$file
done

# Cleanup sam files, which can be very large and contain the same information as the sorted bam files
# rm *.sam
