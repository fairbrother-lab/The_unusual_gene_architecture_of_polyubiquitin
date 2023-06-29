#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --cpus-per-task=3
#SBATCH --mem=30G
#SBATCH --nice
#SBATCH --array=1-22

# chrom=Y
# chrom=${SLURM_ARRAY_TASK_ID}
# filename=gs://gcp-public-data--gnomad/release/2.1.1/vcf/genomes/gnomad.genomes.r2.1.1.sites."$chrom".vcf.bgz
# echo "$filename"
# gsutil cp $filename data/gnomAD/

# chrom=Y
chrom=${SLURM_ARRAY_TASK_ID}
filename=gs://gcp-public-data--gnomad/release/3.1.1/vcf/genomes/gnomad.genomes.v3.1.1.sites.chr"$chrom".vcf.bgz
echo "$filename"
gsutil cp $filename data/gnomAD/
