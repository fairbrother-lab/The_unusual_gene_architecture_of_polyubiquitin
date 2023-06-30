#!/bin/sh

# Postprocess STAR alignment

# preamble
Node=node01
OutDirectory=../../data/group_F_gene_tiling_screen_5ss

# input
Script=../sequencing_helper_files/grep_star_all_standard_process_general.sh
sbatch -w $Node $Script $OutDirectory GroupF-input-grep-1_R1
sbatch -w $Node $Script $OutDirectory GroupF-input-grep-2_R1
sbatch -w $Node $Script $OutDirectory GroupF-input-grep-3_R1

sbatch -w $Node $Script $OutDirectory GroupF-input-grep-1_R2
sbatch -w $Node $Script $OutDirectory GroupF-input-grep-2_R2
sbatch -w $Node $Script $OutDirectory GroupF-input-grep-3_R2

# output
Script=../sequencing_helper_files/grep_star_all_standard_process_general.sh
sbatch -w $Node $Script $OutDirectory GroupF-output-grep-1_R1
sbatch -w $Node $Script $OutDirectory GroupF-output-grep-2_R1
sbatch -w $Node $Script $OutDirectory GroupF-output-grep-3_R1
