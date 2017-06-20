# rseq
A collection of programs for analyzing RNA-seq data.

## Parallel computations
Scripts with the -par prefix invokes LSF batch jobs, executing computations in parallel.

### Example pipeline
* bin/parDecompress.sh <dir> . Unpacks fastq.gz files
* tuxedo2/parAlign.sh <dir> . Aligns sequencing reads to reference genome.
* tuxedo2/parSAM2BAM.sh <dir> . Converts .sam to .bam files.
* tuxedo2/assemble.sh <dir> . Assembles transcript alignemnts.

