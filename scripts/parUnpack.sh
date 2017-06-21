#BSUB -J unpigz
#BSUB -P acc_STARNET
#BSUB -q alloc
#BSUB -W 1:00
#BSUB -R "rusage[mem=500]"
#BSUB -n 8
#BSUB -e logs/error.%J
#BSUB -o logs/output.%J

# USAGE:
# bsub -cwd <dir> < parUnpack.sh
# must be in a clean directory containing only .fastq.gz files -- without unpacked .fastq files.

# Parallel gz
module load pigz

mkdir logs
ls *.fastq.gz | xargs unpigz -k
