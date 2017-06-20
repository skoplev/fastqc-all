#BSUB -J unpigz
#BSUB -P acc_STARNET
#BSUB -q alloc
#BSUB -W 1:00
#BSUB -R "rusage[mem=20000]"
#BSUB -n 8
#BSUB -e logs/error.%J
#BSUB -o logs/output.%J

# bsub -cwd . < parUnpack.sh

# account="acc_STARNET"

# Parallel gz
module load pigz

mkdir logs
ls *.fastq.gz | xargs unpigz -k


# Change directory to data projects folder
# data_dir=$1
# if [[ -n $data_dir ]]; then
# 	cd $data_dir  # otherwise use current working directory
# fi

# mkdir logs
# bsub -J "unpigz" \
# 	-P $account \
# 	-q alloc \
# 	-W 1:00 \
# 	-R "rusage[mem=20000]" \
# 	-n 8 \
# 	-e logs/error.%J \
# 	-o logs/output.%J \
# 	ls *.fastq.gz | xargs unpigz -k
