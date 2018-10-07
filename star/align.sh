# Align RNA-seq using STAR on Minerva supercomputer.
# Loops over fastq.gz files specified in text file, submitting a STAR
# alignemnt LSF job for each fastq.gz file.

# USAGE:
# star/aligh.sh
#
# for paired-end data first create two column file using
# ls *.fastq | xargs -n 2

module load star

mkdir logs
mkdir align

# fastq_list="/sc/orga/projects/STARNET/koples01/case-control-align/file_paths/fastq_files.txt"
fastq_list="/hpc/users/koples01/links/STARNET/koples01/external_projects/lesca_circRNA/fastq_files.txt"
# fastq_list="/sc/orga/projects/STARNET/koples01/case-control-align/file_paths/fastq_files_timeout.txt"

fastq_files=`cat $fastq_list`


# Input specifications
# -----------------------------------------
# Indexed genome
stargtf="/sc/orga/projects/STARNET/koples01/data_bases/HumanGenome/ensemble_annot/Homo_sapiens.GRCh38.89.gtf"

# Genome dir, empty for writing
genome="/sc/orga/projects/STARNET/koples01/case-control-align/genome"
#------------------------------------------

for file in $fastq_files; do
	echo $file

	filename=$(basename $file)

	bsub -J STAR \
		-P acc_STARNET \
		-q premium \
		-W 1:00 \
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
