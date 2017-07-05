#BSUB -J samtools
#BSUB -P acc_STARNET
#BSUB -q alloc
#BSUB -W 12:00
#BSUB -R "rusage[mem=2000]"
#BSUB -n 4
#BSUB -e logs/error.%J
#BSUB -o logs/output.%J

# USAGE:
# bsub -cwd <dir> < tuxedo2/parSAM2BAM.sh

module load samtools

# Convert SAM to BAM files, also sorts based on genomic coordinates
mkdir logs
mkdir bam
mkdir tmp
for file in *.sam; do
	echo "Converting $file"
	samtools sort -@ 8 \
		-T tmp/tmp \
		-O bam \
		-o bam/${file%.*}.bam \
		$file
done

# Cleanup sam files, which can be very large and contain the same information as the sorted bam files
# rm *.sam
