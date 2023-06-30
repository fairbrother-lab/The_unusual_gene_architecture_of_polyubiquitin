#!/bin/sh

# STAR alignment

# preamble
Node=node01
InDirectory=../../data/group_C_gene_tiling_screen_3ss/grep_fastq
OutDirectory=../../data/group_C_gene_tiling_screen_3ss

# input
Index=../../data/custom_star_index/group_C_gene_tiling_screen_3ss_output
Script=../sequencing_helper_files/grep_star_all_standard_general.sh
sbatch -w $Node $Script $Index $InDirectory $OutDirectory GroupC-input-grep-1_R1 GroupC-input-grep-1_R1
sbatch -w $Node $Script $Index $InDirectory $OutDirectory GroupC-input-grep-2_R1 GroupC-input-grep-2_R1
sbatch -w $Node $Script $Index $InDirectory $OutDirectory GroupC-input-grep-3_R1 GroupC-input-grep-3_R1

sbatch -w $Node $Script $Index $InDirectory $OutDirectory GroupC-input-grep-1_R2 GroupC-input-grep-1_R2
sbatch -w $Node $Script $Index $InDirectory $OutDirectory GroupC-input-grep-2_R2 GroupC-input-grep-2_R2
sbatch -w $Node $Script $Index $InDirectory $OutDirectory GroupC-input-grep-3_R2 GroupC-input-grep-3_R2

# output
Index=../../data/custom_star_index/group_C_gene_tiling_screen_3ss_output
Script=../sequencing_helper_files/grep_star_all_standard_general.sh
sbatch -w $Node $Script $Index $InDirectory $OutDirectory GroupC-output-grep-1_R1 GroupC-output-grep-1_R1
sbatch -w $Node $Script $Index $InDirectory $OutDirectory GroupC-output-grep-2_R1 GroupC-output-grep-2_R1
sbatch -w $Node $Script $Index $InDirectory $OutDirectory GroupC-output-grep-3_R1 GroupC-output-grep-3_R1
