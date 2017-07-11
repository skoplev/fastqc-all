#BSUB -J featureCounts
#BSUB -P acc_STARNET
#BSUB -q alloc
#BSUB -W 12:00
#BSUB -R "rusage[mem=2000]"
#BSUB -M 2000
#BSUB -n 4
#BSUB -e logs/error.%J
#BSUB -o logs/output.%J

# USAGE:
# bsub -cwd <dir bam files> < parFeatureCounts.sh

module load subread

annot=~/links/STARNET/koples01/data_bases/HumanGenome/ensemble_annot/Homo_sapiens.GRCh38.89.gtf

mkdir feature_counts
mkdir logs

featureCounts -T 8 \
	-t exon \
	-g gene_id \
	-a $annot \
	-o feature_counts/gene_counts.txt \
	*.bam
