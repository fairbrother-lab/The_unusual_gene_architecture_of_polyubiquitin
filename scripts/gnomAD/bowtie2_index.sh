#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=20G
#SBATCH --job-name=index_introns



bowtie2-build \
-- quiet
-f data/hg38.ucsc_gencode_v41.introns_by_chromosome/* \
data/bowtie2/hg38_introns
# -f data/hg19.ucsc_gencode_v19.introns_by_chromosome/* \
# data/bowtie2/hg19_introns