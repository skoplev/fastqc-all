# Align 

# USAGE:
# star/align.sh 

mkdir logs

fastq_list=""

fastq_files = `cat $fastq_list`

genome=/sc/orga/projects/STARNET/vamsi/ensemble.H19/
stargtf=/sc/orga/projects/STARNET/vamsi/ensemble/Homo_sapiens.GRCh37.75.gtf
ucscGTF=/sc/orga/projects/STARNET/vamsi/ucscgtf/ucsc.gtf


module load star

# for file in *.fastq; do
# cat fastq_list | while read line; do
for file in $fastq_files; do
	echo $file

	filename=$(basename $file)

	#BSUB -J STAR_"${filename}"
	#BSUB -P acc_STARNET
	#BSUB -q alloc
	#BSUB -W 6:00
	#BSUB -R "rusage[mem=4000]"
	#BSUB -n 8
	#BSUB -e logs/error.%J
	#BSUB -o logs/output.%J

	STAR --genomeDir $genome \
		--sjdbGTFfile $stargtf \
		--readFilesIn $file \
		--readFilesCommand zcat \
		--runThreadN 24 \
		--outReadsUnmapped Fastx \
		--chimSegmentMin 15 \
		--chimJunctionOverhangMin 15 \
		--outSAMstrandField intronMotif \
		--outStd BAM_SortedByCoordinate \
		--outSAMtype BAM \
		SortedByCoordinate >alignments.bam
done

