#!/bin/sh

# Process sequencing data.

# # align using STAR
# sh star_all_standard_group_F.sh
# sh star_all_standard_process_group_F.sh
# multiqc ../../data/group_F_gene_tiling_screen_3ss/star_align/* -o ../../data/group_F_gene_tiling_screen_3ss/star_align/multiqc/ -v -f

# # # postprocess data
# Rscript postprocess_standard_group_F.R
# Rscript tiling_analysis_group_F.R 
# tiling_bgToBed_group_F.sh

# grep and align using STAR
sh grep_tiling_group_F.sh
sh grep_star_all_standard_group_F.sh
# sh grep_star_all_standard_process_group_F.sh

# postprocess data
Rscript tiling_analysis_group_F.R 
Rscript genome_browser_tracks_replot_group_F.R 
