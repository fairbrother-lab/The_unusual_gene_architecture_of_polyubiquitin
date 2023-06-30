#!/bin/R

# load packages
library(tidyverse)

# load tables
Group_F_bam2gr_in_join <- read_tsv("../../results/group_F_gene_tiling_screen_5ss/Group_F_bam2gr_in_join_updated.txt.gz")
Group_F_bam2gr_out_join <- read_tsv("../../results/group_F_gene_tiling_screen_5ss/Group_F_bam2gr_out_join_updated.txt.gz")

# get position in genome
Group_F_bam2gr_in_join <- Group_F_bam2gr_in_join %>% 
	mutate(tile_start_in_genome = ifelse(strand == "+", start-1+tile_start, end+1-tile_end)) %>% 
	mutate(tile_end_in_genome = ifelse(strand == "+", start-1+tile_end, end+1-tile_start))
write_tsv(Group_F_bam2gr_in_join, gzfile("../../results/group_F_gene_tiling_screen_5ss/Group_F_bam2gr_in_join_updated.txt.gz"))
Group_F_bam2gr_in_join <- Group_F_bam2gr_in_join %>% 
	rowwise() %>% mutate(sum_input_n = sum(tile_n_rep_1, tile_n_rep_2, tile_n_rep_3, na.rm=T)) %>% mutate(log_sum_input_n = log10(sum_input_n)) %>% ungroup()
write_tsv(Group_F_bam2gr_in_join, gzfile("../../results/group_F_gene_tiling_screen_5ss/Group_F_bedtrack_in_join_updated.txt.gz"))

Group_F_bam2gr_out_join <- Group_F_bam2gr_out_join %>% 
	mutate(exon_start_in_genome = ifelse(strand == "+", start-1+exon_start, end+1-exon_end)) %>% 
	mutate(exon_end_in_genome = ifelse(strand == "+", start-1+exon_end, end+1-exon_start))
write_tsv(Group_F_bam2gr_out_join, gzfile("../../results/group_F_gene_tiling_screen_5ss/Group_F_bam2gr_out_join_updated.txt.gz"))
Group_F_bam2gr_out_join <- Group_F_bam2gr_out_join %>% 
	rowwise() %>% mutate(sum_output_n = sum(exon_n_rep_1, exon_n_rep_2, exon_n_rep_3, na.rm=T)) %>% mutate(log_sum_output_n = log10(sum_output_n)) %>% ungroup()
write_tsv(Group_F_bam2gr_out_join, gzfile("../../results/group_F_gene_tiling_screen_5ss/Group_F_bedtrack_out_join_updated.txt.gz"))

# input
# 	custom UCSC track
Group_F_bedtrack_in_join <- Group_F_bam2gr_in_join %>% 
	rowwise() %>% mutate(
		`#chrom` = seqnames, 
		chromStart = tile_start_in_genome-1, 
		chromEnd = tile_end_in_genome, 
		name = tile_name, 
		score = log_sum_input_n, 
		strand = strand, 
		thickStart = tile_start_in_genome-1, 
		thickEnd = tile_end_in_genome
	) %>% ungroup() %>% mutate(
		itemRGB = paste(254-round(254*(score-min(score, na.rm=T))/(max(score, na.rm=T)-min(score, na.rm=T))), 254-round(254*(score-min(score, na.rm=T))/(max(score, na.rm=T)-min(score, na.rm=T))), 254, sep=",")
	) %>% 
	dplyr::select(`#chrom`, chromStart, chromEnd, name, score, strand, thickStart, thickEnd, itemRGB) %>% 
	arrange(`#chrom`, chromStart, chromEnd)

# 	write BED file with header
write_tsv(Group_F_bedtrack_in_join, "../../results/group_F_gene_tiling_screen_5ss/Group_F_bedtrack_in_join_updated.bed")
file_temp <- file("../../results/group_F_gene_tiling_screen_5ss/Group_F_bedtrack_in_join_updated.bed", 'r+')
bed_header <- 'track name="Full_tiling_input_5ss_updated" description="Full 5ss gene tiling input updated log10 input read counts" visibility=2 itemRgb="On"'
writeLines(c(bed_header, readLines(file_temp)), con=file_temp)
close(file_temp)

# output
# 	custom UCSC track
Group_F_bedtrack_out_join <- Group_F_bam2gr_out_join %>% 
	rowwise() %>% mutate(
		`#chrom` = seqnames, 
		chromStart = exon_start_in_genome-1, 
		chromEnd = exon_end_in_genome, 
		name = exon_name, 
		score = log_sum_output_n, 
		strand = strand, 
		thickStart = exon_start_in_genome-1, 
		thickEnd = exon_end_in_genome
	) %>% ungroup() %>% mutate(
		itemRGB = paste(254-round(254*(score-min(score, na.rm=T))/(max(score, na.rm=T)-min(score, na.rm=T))), 254-round(254*(score-min(score, na.rm=T))/(max(score, na.rm=T)-min(score, na.rm=T))), 254, sep=",")
	) %>% 
	dplyr::select(`#chrom`, chromStart, chromEnd, name, score, strand, thickStart, thickEnd, itemRGB) %>% 
	arrange(`#chrom`, chromStart, chromEnd)
write_tsv(Group_F_bam2gr_out_join, gzfile("../../results/group_F_gene_tiling_screen_5ss/Group_F_bedtrack_out_join_updated.txt.gz"))

# 	write BED file with header
write_tsv(Group_F_bedtrack_out_join, "../../results/group_F_gene_tiling_screen_5ss/Group_F_bedtrack_out_join_updated.bed")
file_temp <- file("../../results/group_F_gene_tiling_screen_5ss/Group_F_bedtrack_out_join_updated.bed", 'r+')
bed_header <- 'track name="Full_tiling_output_5ss_updated" description="Full 5ss gene tiling output updated log10 output read counts" visibility=2 itemRgb="On"'
writeLines(c(bed_header, readLines(file_temp)), con=file_temp)
close(file_temp)

# scores
Group_F_bam2gr_scores_join <- Group_F_bam2gr_out_join %>% 
	left_join(Group_F_bam2gr_in_join) %>% 
	mutate(log_sum_norm_out_n = log_sum_output_n-log_sum_input_n)
write_tsv(Group_F_bam2gr_scores_join, gzfile("../../results/group_F_gene_tiling_screen_5ss/Group_F_bedtrack_scores_join_updated.txt.gz"))

Group_F_bedtrack_scores_join <- Group_F_bam2gr_scores_join %>% 
	rowwise() %>% mutate(
		`#chrom` = seqnames, 
		chromStart = exon_start_in_genome-1, 
		chromEnd = exon_end_in_genome, 
		name = exon_name, 
		score = log_sum_norm_out_n, 
		strand = strand, 
		thickStart = exon_start_in_genome-1, 
		thickEnd = exon_end_in_genome
	) %>% ungroup() %>% mutate(
		itemRGB = paste(254-round(254*(score-min(score, na.rm=T))/(max(score, na.rm=T)-min(score, na.rm=T))), 254-round(254*(score-min(score, na.rm=T))/(max(score, na.rm=T)-min(score, na.rm=T))), 254, sep=",")
	) %>% 
	filter(!is.na(score)) %>% 
	# filter(tile_n_rep_1>=20, tile_n_rep_2>=20, tile_n_rep_3>=20) %>% 
	# filter(exon_n_rep_1>=20, exon_n_rep_2>=20, exon_n_rep_3>=20) %>% 
	dplyr::select(`#chrom`, chromStart, chromEnd, name, score, strand, thickStart, thickEnd, itemRGB) %>% 
	arrange(`#chrom`, chromStart, chromEnd)

# 	write BED file with header
write_tsv(Group_F_bedtrack_scores_join, "../../results/group_F_gene_tiling_screen_5ss/Group_F_bedtrack_scores_join_updated.bed")
file_temp <- file("../../results/group_F_gene_tiling_screen_5ss/Group_F_bedtrack_scores_join_updated.bed", 'r+')
bed_header <- 'track name="Full_tiling_scores_5ss_updated" description="Full 5ss gene tiling scores updated log10 normalized read counts" visibility=2 itemRgb="On"'
writeLines(c(bed_header, readLines(file_temp)), con=file_temp)
close(file_temp)
