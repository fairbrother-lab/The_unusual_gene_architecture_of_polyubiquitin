#!/bin/sh

# STAR alignment

# preamble
Node=node01
InDirectory=../../data/group_F_gene_tiling_screen_5ss/grep_fastq
OutDirectory=../../data/group_F_gene_tiling_screen_5ss

# input
Index=../../data/custom_star_index/group_F_gene_tiling_screen_5ss_output
Script=../sequencing_helper_files/grep_star_all_standard_general.sh
sbatch -w $Node $Script $Index $InDirectory $OutDirectory GroupF-input-grep-1_R1 GroupF-input-grep-1_R1
sbatch -w $Node $Script $Index $InDirectory $OutDirectory GroupF-input-grep-2_R1 GroupF-input-grep-2_R1
sbatch -w $Node $Script $Index $InDirectory $OutDirectory GroupF-input-grep-3_R1 GroupF-input-grep-3_R1

sbatch -w $Node $Script $Index $InDirectory $OutDirectory GroupF-input-grep-1_R2 GroupF-input-grep-1_R2
sbatch -w $Node $Script $Index $InDirectory $OutDirectory GroupF-input-grep-2_R2 GroupF-input-grep-2_R2
sbatch -w $Node $Script $Index $InDirectory $OutDirectory GroupF-input-grep-3_R2 GroupF-input-grep-3_R2

# output
Index=../../data/custom_star_index/group_F_gene_tiling_screen_5ss_output
Script=../sequencing_helper_files/grep_star_all_standard_general.sh
sbatch -w $Node $Script $Index $InDirectory $OutDirectory GroupF-output-grep-1_R1 GroupF-output-grep-1_R1
sbatch -w $Node $Script $Index $InDirectory $OutDirectory GroupF-output-grep-2_R1 GroupF-output-grep-2_R1
sbatch -w $Node $Script $Index $InDirectory $OutDirectory GroupF-output-grep-3_R1 GroupF-output-grep-3_R1
