# Align RNA-seq using STAR
# Loops over fastq.gz files specified in text file, submitting a STAR
# alignemnt LSF job for each fastq.gz file.

# USAGE:
# star/aligh.sh

module load star

mkdir logs

# fastq_list="/sc/orga/projects/STARNET/koples01/case-control-align/test_fastq_files.txt"
fastq_list="/sc/orga/projects/STARNET/koples01/case-control-align/fastq_files.txt"

fastq_files=`cat $fastq_list`


# Indexed genome
stargtf="/sc/orga/projects/STARNET/koples01/data_bases/HumanGenome/ensemble_annot/Homo_sapiens.GRCh38.89.gtf"

# Genome dir, empty for writing
genome="/sc/orga/projects/STARNET/koples01/case-control-align/genome"

ucscGTF="/sc/orga/projects/STARNET/vamsi/ucscgtf/ucsc.gtf"

mkdir align

# for file in *.fastq; do
# cat fastq_list | while read line; do
for file in $fastq_files; do
	echo $file

	filename=$(basename $file)

	bsub -J STAR \
		-P acc_STARNET \
		-q alloc \
		-W 6:00 \
		-R "rusage[mem=6000]" \
		-M 6000 \
		-n 8 \
		-e logs/error.%J \
		-o logs/output.%J \
		-R "span[hosts=1]" \
		STAR --genomeDir $genome \
			--sjdbGTFfile $stargtf \
			--readFilesIn $file \
			--readFilesCommand zcat \
			--runThreadN 16 \
			--outReadsUnmapped Fastx \
			--chimSegmentMin 15 \
			--chimJunctionOverhangMin 15 \
			--outSAMstrandField intronMotif \
			--outSAMtype BAM SortedByCoordinate \
			--outFileNamePrefix align/$filename.
done

