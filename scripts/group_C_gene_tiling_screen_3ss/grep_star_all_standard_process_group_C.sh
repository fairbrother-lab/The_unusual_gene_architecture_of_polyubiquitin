#!/bin/sh

# Postprocess STAR alignment

# preamble
Node=node01
OutDirectory=../../data/group_C_gene_tiling_screen_3ss

# input
Script=../sequencing_helper_files/grep_star_all_standard_process_general.sh
sbatch -w $Node $Script $OutDirectory GroupC-input-grep-1_R1
sbatch -w $Node $Script $OutDirectory GroupC-input-grep-2_R1
sbatch -w $Node $Script $OutDirectory GroupC-input-grep-3_R1

sbatch -w $Node $Script $OutDirectory GroupC-input-grep-1_R2
sbatch -w $Node $Script $OutDirectory GroupC-input-grep-2_R2
sbatch -w $Node $Script $OutDirectory GroupC-input-grep-3_R2

# output
Script=../sequencing_helper_files/grep_star_all_standard_process_general.sh
sbatch -w $Node $Script $OutDirectory GroupC-output-grep-1_R1
sbatch -w $Node $Script $OutDirectory GroupC-output-grep-2_R1
sbatch -w $Node $Script $OutDirectory GroupC-output-grep-3_R1
