# Make STAR index for human genome.

# USAGE 
# bsub < star/index.sh

module load star

mkdir logs

#BSUB -J STAR_index
#BSUB -P acc_STARNET
#BSUB -q premium
#BSUB -W 10:00
#BSUB -R "rusage[mem=8000]"
#BSUB -M 8000
#BSUB -n 8
#BSUB -R "span[hosts=1]"
#BSUB -e logs/error.%J
#BSUB -o logs/output.%J

STAR --runThreadN 16 \
	--runMode genomeGenerate \
	--genomeDir /sc/orga/projects/STARNET/koples01/case-control-align/genome \
	--genomeFastaFiles /sc/orga/projects/STARNET/koples01/data_bases/HumanGenome/ensembl_dna_r89/GRCh38_r89.all.fa \
	--sjdbGTFfile /sc/orga/projects/STARNET/koples01/data_bases/HumanGenome/ensemble_annot/Homo_sapiens.GRCh38.89.gtf
