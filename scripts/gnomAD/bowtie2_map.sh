#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=20G



# BOWTIE_GENOME_INDEX=data/bowtie2/hg19_introns.fa
# out=data/insert_intron_alignments.sam
BOWTIE_GENOME_INDEX=data/bowtie2/hg38_introns.fa
out=data/hg_38_inserts_x_introns.sam

# insert_fastas="data/gnomADv2.1.1_insert_fastas/gnomAD_v2.1.1_inserts_chrX.fa","data/gnomADv2.1.1_insert_fastas/gnomAD_v2.1.1_inserts_chrY.fa"
# for i in {1..22}
# 	do
# 		insert_fastas="$insert_fastas","data/gnomADv2.1.1_insert_fastas/gnomAD_v2.1.1_inserts_chr$i.fa"
# 	done
# echo $insert_fastas
insert_fastas="data/gnomADv3.1.1_insert_fastas/gnomAD_v3.1.1_inserts_chrX.fa","data/gnomADv3.1.1_insert_fastas/gnomAD_v3.1.1_inserts_chrY.fa"
for i in {1..22}
	do
		insert_fastas="$insert_fastas","data/gnomADv3.1.1_insert_fastas/gnomAD_v3.1.1_inserts_chr$i.fa"
	done
echo $insert_fastas

bowtie2 \
--end-to-end --very-sensitive \
--time \
--no-unal \
--threads 9 \
-x $BOWTIE_GENOME_INDEX \
-fU $insert_fastas \
-S $out 