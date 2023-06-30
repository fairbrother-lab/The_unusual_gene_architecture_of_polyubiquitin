#!/bin/R

library(tidyverse)
library(data.table)
library(rtracklayer)

Group_F_bedtrack_scores_join <- as_tibble(fread("../../results/group_F_gene_tiling_screen_5ss/Group_F_bedtrack_scores_join_updated.txt.gz"))

Group_F_bedtrack_scores_join <- Group_F_bedtrack_scores_join %>% 
	mutate(
		ss_start = exon_end+1,
		ss_end = exon_end+2
	) %>% 
	mutate(
		ss_width = ss_end-ss_start+1,
		ss_strand = exon_strand,
	) %>% 
	mutate(
		ss_name = paste(gene_name, ss_start, ss_end, sep="_"), 
		ss_start_in_genome = ifelse(strand == "+", start-1+ss_start, end+1-ss_end), 
		ss_end_in_genome = ifelse(strand == "+", start-1+ss_end, end+1-ss_start),
	)

Group_F_bedtrack_splice_site_join <- Group_F_bedtrack_scores_join %>% 
	group_by(seqnames, gene_name, strand, ss_start, ss_end, ss_width, ss_strand, ss_name, ss_start_in_genome, ss_end_in_genome) %>% 
	summarise(
		filter_min_output_reads = all(sum(exon_n_rep_1, na.rm=T)>=20, sum(exon_n_rep_2, na.rm=T)>=20, sum(exon_n_rep_3, na.rm=T)>=20), 
		filter_min_input_reads = all(sum(tile_n_rep_1, na.rm=T)>=20, sum(tile_n_rep_2, na.rm=T)>=20, sum(tile_n_rep_3, na.rm=T)>=20), 
		log10_5ss_enrich_score_sum = log10(sum(sum_output_n, na.rm=T)/sum(sum_input_n, na.rm=T)),
		log10_5ss_enrich_score_max = max(log10(sum_output_n/sum_input_n), na.rm=T)
	) %>% 
	ungroup()

# add DEPRECATED
Group_F_scores_join_bed_updated <- import("../../results/group_F_gene_tiling_screen_5ss/DEPRECATED/Group_F_scores_join_bed_updated.bg", format="bedGraph")
Group_F_scores_join_bed_updated <- Group_F_scores_join_bed_updated %>% 
	as_tibble() %>% 
	mutate(ss_start_in_genome = start, ss_end_in_genome = end, log10_5ss_enrich_score_DEPRECATED = log10(score)) %>% 
	dplyr::select(seqnames, ss_start_in_genome, ss_end_in_genome, log10_5ss_enrich_score_DEPRECATED)

Group_F_bedtrack_splice_site_join <- Group_F_bedtrack_splice_site_join %>% 
	full_join(Group_F_scores_join_bed_updated)
write_tsv(Group_F_bedtrack_splice_site_join, gzfile("../../results/group_F_gene_tiling_screen_5ss/Group_F_bedtrack_splice_site_join_updated.txt.gz"))

# custom track
Group_F_bedtrack_splice_site_join_sum <- Group_F_bedtrack_splice_site_join %>% 
	rowwise() %>% mutate(
		`#chrom` = seqnames, 
		chromStart = ss_start_in_genome-1,
		chromEnd = ss_end_in_genome, 
		name = ss_name, 
		score = log10_5ss_enrich_score_sum, 
		strand = strand, 
		thickStart = ss_start_in_genome-1, 
		thickEnd = ss_end_in_genome
	) %>% ungroup() %>% mutate(
		itemRGB = paste(254-round(254*(score-min(score, na.rm=T))/(max(score, na.rm=T)-min(score, na.rm=T))), 254-round(254*(score-min(score, na.rm=T))/(max(score, na.rm=T)-min(score, na.rm=T))), 254, sep=",")
	) %>% 
	filter(!is.na(score)) %>% 
	# filter(filter_min_output_reads) %>% 
	# filter(filter_min_input_reads) %>% 
	dplyr::select(`#chrom`, chromStart, chromEnd, name, score, strand, thickStart, thickEnd, itemRGB) %>% 
	arrange(`#chrom`, chromStart, chromEnd)

Group_F_bedtrack_splice_site_join_max <- Group_F_bedtrack_splice_site_join %>% 
	rowwise() %>% mutate(
		`#chrom` = seqnames, 
		chromStart = ss_start_in_genome-1,
		chromEnd = ss_end_in_genome, 
		name = ss_name, 
		score = log10_5ss_enrich_score_max, 
		strand = strand, 
		thickStart = ss_start_in_genome-1, 
		thickEnd = ss_end_in_genome
	) %>% ungroup() %>% mutate(
		itemRGB = paste(254-round(254*(score-min(score, na.rm=T))/(max(score, na.rm=T)-min(score, na.rm=T))), 254-round(254*(score-min(score, na.rm=T))/(max(score, na.rm=T)-min(score, na.rm=T))), 254, sep=",")
	) %>% 
	filter(!is.na(score)) %>% 
	# filter(filter_min_output_reads) %>% 
	# filter(filter_min_input_reads) %>% 
	dplyr::select(`#chrom`, chromStart, chromEnd, name, score, strand, thickStart, thickEnd, itemRGB) %>% 
	arrange(`#chrom`, chromStart, chromEnd)

# 	write BED file with header
write_tsv(Group_F_bedtrack_splice_site_join_sum, "../../results/group_F_gene_tiling_screen_5ss/Group_F_bedtrack_splice_site_join_sum_updated_sum.bed")
file_temp <- file("../../results/group_F_gene_tiling_screen_5ss/Group_F_bedtrack_splice_site_join_sum_updated_sum.bed", 'r+')
bed_header <- 'track name="Full_tiling_splice_site_5ss_updated_sum" description="Full 5ss gene tiling splice sites updated log10 5ss enrich score sum" visibility=2 itemRgb="On"'
writeLines(c(bed_header, readLines(file_temp)), con=file_temp)
close(file_temp)

write_tsv(Group_F_bedtrack_splice_site_join_max, "../../results/group_F_gene_tiling_screen_5ss/Group_F_bedtrack_splice_site_join_max_updated_max.bed")
file_temp <- file("../../results/group_F_gene_tiling_screen_5ss/Group_F_bedtrack_splice_site_join_max_updated_max.bed", 'r+')
bed_header <- 'track name="Full_tiling_splice_site_5ss_updated_max" description="Full 5ss gene tiling splice sites updated log10 5ss enrich score max" visibility=2 itemRgb="On"'
writeLines(c(bed_header, readLines(file_temp)), con=file_temp)
close(file_temp)
