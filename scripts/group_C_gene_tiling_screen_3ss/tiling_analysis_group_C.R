#!/bin/R

library(tidyverse)
library(data.table)
library(rtracklayer)
library(plyranges)
library(zoo)
library(ggseqlogo)

# library(BSgenome.Hsapiens.UCSC.hg19)
library(BSgenome.Hsapiens.UCSC.hg38)
# hg19 <- BSgenome.Hsapiens.UCSC.hg19
hg38 <- BSgenome.Hsapiens.UCSC.hg38

# load gff
file_gff <- "../../../final-barcoded-mapsy/data/three_prime_splice_site/gencode.v32.basic.annotation.gff3.gz"
loaded_gff <- rtracklayer::import(file_gff, format="gff") %>% 
	dplyr::select(-c(Parent, tag, ont))
# 	list of genes to tile
list_genes <- c("BRCA1", "BRCA2", "LDLR")
# 	get gene ranges
gene_ranges <- loaded_gff %>% 
	filter(type == "gene") %>% 
	filter(gene_name %in% list_genes)

# get sequences
gene_ranges$sequences <- getSeq(hg38, gene_ranges, as.character=TRUE)
gene_ranges_tb <- as_tibble(gene_ranges)

# get positions
gene_ranges_temp_tb <- gene_ranges_tb[c("seqnames", "gene_name", "start", "end", "width", "strand")]
write_tsv(gene_ranges_temp_tb, "../../results/group_C_gene_tiling_screen_3ss/gene_ranges_temp_tb.txt")

# # get exon boundaries
# exon_ranges <- loaded_gff %>% 
# 	filter(type == "exon") %>% 
# 	filter(gene_name %in% list_genes)

# bam2granges version
library(Repitools)

group_C_bam2gr <- NULL
group_C_bam2gr$in_R1_bam$rep_1 <- BAM2GRanges("../../data/group_C_gene_tiling_screen_3ss/star_align/GroupC-input-grep-1_R1_001.Aligned.out.bam")
group_C_bam2gr$in_R1_bam$rep_2 <- BAM2GRanges("../../data/group_C_gene_tiling_screen_3ss/star_align/GroupC-input-grep-2_R1_001.Aligned.out.bam")
group_C_bam2gr$in_R1_bam$rep_3 <- BAM2GRanges("../../data/group_C_gene_tiling_screen_3ss/star_align/GroupC-input-grep-3_R1_001.Aligned.out.bam")
group_C_bam2gr$out_R1_bam$rep_1 <- BAM2GRanges("../../data/group_C_gene_tiling_screen_3ss/star_align/GroupC-output-grep-1_R1_001.Aligned.out.bam")
group_C_bam2gr$out_R1_bam$rep_2 <- BAM2GRanges("../../data/group_C_gene_tiling_screen_3ss/star_align/GroupC-output-grep-2_R1_001.Aligned.out.bam")
group_C_bam2gr$out_R1_bam$rep_3 <- BAM2GRanges("../../data/group_C_gene_tiling_screen_3ss/star_align/GroupC-output-grep-3_R1_001.Aligned.out.bam")

# get true ends from tile size
end(group_C_bam2gr$in_R1_bam$rep_1) <- start(group_C_bam2gr$in_R1_bam$rep_1)+150-1
end(group_C_bam2gr$in_R1_bam$rep_2) <- start(group_C_bam2gr$in_R1_bam$rep_2)+150-1
end(group_C_bam2gr$in_R1_bam$rep_3) <- start(group_C_bam2gr$in_R1_bam$rep_3)+150-1

group_C_bam2gr$in_R1_bam$rep_1 <- trim(group_C_bam2gr$in_R1_bam$rep_1)
group_C_bam2gr$in_R1_bam$rep_2 <- trim(group_C_bam2gr$in_R1_bam$rep_2)
group_C_bam2gr$in_R1_bam$rep_3 <- trim(group_C_bam2gr$in_R1_bam$rep_3)

# load input bams
group_C_bam2gr$in_R1_bam2fil$rep_1 <- group_C_bam2gr$in_R1_bam$rep_1 %>% filter(strand == "+") %>% filter(end %% 20 == 10)
group_C_bam2gr$in_R1_bam2fil$rep_2 <- group_C_bam2gr$in_R1_bam$rep_2 %>% filter(strand == "+") %>% filter(end %% 20 == 10)
group_C_bam2gr$in_R1_bam2fil$rep_3 <- group_C_bam2gr$in_R1_bam$rep_3 %>% filter(strand == "+") %>% filter(end %% 20 == 10)

group_C_bam2gr$in_R1_bam2gr$rep_1 <- group_C_bam2gr$in_R1_bam2fil$rep_1 %>% as_tibble() %>% 
	mutate(gene_name = seqnames, tile_start = start, tile_end = end, tile_width = width, tile_strand = strand) %>% 
	mutate(tile_name = paste(seqnames, tile_start, tile_end, sep="_"))
group_C_bam2gr$in_R1_bam2gr$rep_2 <- group_C_bam2gr$in_R1_bam2fil$rep_2 %>% as_tibble() %>% 
	mutate(gene_name = seqnames, tile_start = start, tile_end = end, tile_width = width, tile_strand = strand) %>% 
	mutate(tile_name = paste(seqnames, tile_start, tile_end, sep="_"))
group_C_bam2gr$in_R1_bam2gr$rep_3 <- group_C_bam2gr$in_R1_bam2fil$rep_3 %>% as_tibble() %>% 
	mutate(gene_name = seqnames, tile_start = start, tile_end = end, tile_width = width, tile_strand = strand) %>% 
	mutate(tile_name = paste(seqnames, tile_start, tile_end, sep="_"))

# count input tiles
group_C_bam2gr$in_R1_norm$rep_1 <- group_C_bam2gr$in_R1_bam2gr$rep_1 %>% 
	group_by(gene_name, tile_start, tile_end, tile_width, tile_strand, tile_name) %>% tally() %>% ungroup() %>% 
	dplyr::rename(tile_n = n)
group_C_bam2gr$in_R1_norm$rep_2 <- group_C_bam2gr$in_R1_bam2gr$rep_2 %>% 
	group_by(gene_name, tile_start, tile_end, tile_width, tile_strand, tile_name) %>% tally() %>% ungroup() %>% 
	dplyr::rename(tile_n = n)
group_C_bam2gr$in_R1_norm$rep_3 <- group_C_bam2gr$in_R1_bam2gr$rep_3 %>% 
	group_by(gene_name, tile_start, tile_end, tile_width, tile_strand, tile_name) %>% tally() %>% ungroup() %>% 
	dplyr::rename(tile_n = n)

# save count input tiles
group_C_bam2gr_in_join <- full_join(
	group_C_bam2gr$in_R1_norm$rep_1 %>% dplyr::rename(tile_n_rep_1 = tile_n), full_join(
		group_C_bam2gr$in_R1_norm$rep_2 %>% dplyr::rename(tile_n_rep_2 = tile_n), 
			group_C_bam2gr$in_R1_norm$rep_3 %>% dplyr::rename(tile_n_rep_3 = tile_n)))
group_C_bam2gr_in_join <- gene_ranges_temp_tb %>% inner_join(group_C_bam2gr_in_join) %>% 
	mutate(tile_start_in_genome = ifelse(strand == "+", start-1+tile_start, end+1-tile_end)) %>% 
	mutate(tile_end_in_genome = ifelse(strand == "+", start-1+tile_end, end+1-tile_start))
write_tsv(group_C_bam2gr_in_join, gzfile("../../results/group_C_gene_tiling_screen_3ss/Group_C_bam2gr_in_join_updated.txt.gz"))

# load output bams
group_C_bam2gr$out_R1_bam2fil$rep_1 <- group_C_bam2gr$out_R1_bam$rep_1 %>% filter(strand == "+") %>% filter(end %% 20 == 10)
group_C_bam2gr$out_R1_bam2fil$rep_2 <- group_C_bam2gr$out_R1_bam$rep_2 %>% filter(strand == "+") %>% filter(end %% 20 == 10)
group_C_bam2gr$out_R1_bam2fil$rep_3 <- group_C_bam2gr$out_R1_bam$rep_3 %>% filter(strand == "+") %>% filter(end %% 20 == 10)

group_C_bam2gr$out_R1_bam2gr$rep_1 <- group_C_bam2gr$out_R1_bam2fil$rep_1 %>% as_tibble() %>% 
	mutate(gene_name = seqnames, tile_start = end-150+1, tile_end = end, tile_width = 150, tile_strand = strand, 
		exon_start = start, exon_end = end, exon_width = width, exon_strand = strand) %>% 
	mutate(tile_name = paste(gene_name, tile_start, tile_end, sep="_")) %>% 
	mutate(exon_name = paste(gene_name, exon_start, exon_end, sep="_")) %>% 
	dplyr::rename(start = start, end = end, width = width)
group_C_bam2gr$out_R1_bam2gr$rep_2 <- group_C_bam2gr$out_R1_bam2fil$rep_2 %>% as_tibble() %>% 
	mutate(gene_name = seqnames, tile_start = end-150+1, tile_end = end, tile_width = 150, tile_strand = strand, 
		exon_start = start, exon_end = end, exon_width = width, exon_strand = strand) %>% 
	mutate(tile_name = paste(gene_name, tile_start, tile_end, sep="_")) %>% 
	mutate(exon_name = paste(gene_name, exon_start, exon_end, sep="_")) %>% 
	dplyr::rename(start = start, end = end, width = width)
group_C_bam2gr$out_R1_bam2gr$rep_3 <- group_C_bam2gr$out_R1_bam2fil$rep_3 %>% as_tibble() %>% 
	mutate(gene_name = seqnames, tile_start = end-150+1, tile_end = end, tile_width = 150, tile_strand = strand, 
		exon_start = start, exon_end = end, exon_width = width, exon_strand = strand) %>% 
	mutate(tile_name = paste(gene_name, tile_start, tile_end, sep="_")) %>% 
	mutate(exon_name = paste(gene_name, exon_start, exon_end, sep="_")) %>% 
	dplyr::rename(start = start, end = end, width = width)

# count output exons
group_C_bam2gr$out_R1_norm$rep_1 <- group_C_bam2gr$out_R1_bam2gr$rep_1 %>% 
	group_by(gene_name, exon_start, exon_end, exon_width, exon_strand, exon_name, 
		tile_start, tile_end, tile_width, tile_strand, tile_name) %>% tally() %>% ungroup() %>% 
	dplyr::rename(exon_n = n)
group_C_bam2gr$out_R1_norm$rep_2 <- group_C_bam2gr$out_R1_bam2gr$rep_2 %>% 
	group_by(gene_name, exon_start, exon_end, exon_width, exon_strand, exon_name, 
		tile_start, tile_end, tile_width, tile_strand, tile_name) %>% tally() %>% ungroup() %>% 
	dplyr::rename(exon_n = n)
group_C_bam2gr$out_R1_norm$rep_3 <- group_C_bam2gr$out_R1_bam2gr$rep_3 %>% 
	group_by(gene_name, exon_start, exon_end, exon_width, exon_strand, exon_name, 
		tile_start, tile_end, tile_width, tile_strand, tile_name) %>% tally() %>% ungroup() %>% 
	dplyr::rename(exon_n = n)

# save count output exons
group_C_bam2gr_out_join <- full_join(
	group_C_bam2gr$out_R1_norm$rep_1 %>% dplyr::rename(exon_n_rep_1 = exon_n), full_join(
		group_C_bam2gr$out_R1_norm$rep_2 %>% dplyr::rename(exon_n_rep_2 = exon_n), 
			group_C_bam2gr$out_R1_norm$rep_3 %>% dplyr::rename(exon_n_rep_3 = exon_n)))
group_C_bam2gr_out_join <- gene_ranges_temp_tb %>% inner_join(group_C_bam2gr_out_join) %>% 
	mutate(exon_start_in_genome = ifelse(strand == "+", start-1+exon_start, end+1-exon_end)) %>% 
	mutate(exon_end_in_genome = ifelse(strand == "+", start-1+exon_end, end+1-exon_start))
write_tsv(group_C_bam2gr_out_join, gzfile("../../results/group_C_gene_tiling_screen_3ss/Group_C_bam2gr_out_join_updated.txt.gz"))

# DEPRECATED
# # join for normalization
# group_C_bam2gr$final_R1_norm$rep_1 <- group_C_bam2gr$out_R1_norm$rep_1 %>% 
# 	left_join(group_C_bam2gr$in_R1_norm$rep_1)
# group_C_bam2gr$final_R1_norm$rep_2 <- group_C_bam2gr$out_R1_norm$rep_2 %>% 
# 	left_join(group_C_bam2gr$in_R1_norm$rep_2)
# group_C_bam2gr$final_R1_norm$rep_3 <- group_C_bam2gr$out_R1_norm$rep_3 %>% 
# 	left_join(group_C_bam2gr$in_R1_norm$rep_3)

# # enrichment of exons sharing 3ss relative to tiles with shared 3' end
# group_C_bam2gr$splice_site_R1_norm$rep_1 <- group_C_bam2gr$final_R1_norm$rep_1 %>% 
# 	mutate(position_in_gene = exon_start) %>% 
# 	group_by(gene_name, position_in_gene) %>% summarise(
# 		sum_exon_n_rep_1 = sum(exon_n, na.rm=T), 
# 		sum_tile_n_rep_1 = sum(tile_n, na.rm=T), 
# 		three_ss_enrich_rep_1 = sum(exon_n, na.rm=T)/sum(tile_n, na.rm=T)) %>% 
# 	ungroup()
# group_C_bam2gr$splice_site_R1_norm$rep_2 <- group_C_bam2gr$final_R1_norm$rep_2 %>% 
# 	mutate(position_in_gene = exon_start) %>% 
# 	group_by(gene_name, position_in_gene) %>% summarise(
# 		sum_exon_n_rep_2 = sum(exon_n, na.rm=T), 
# 		sum_tile_n_rep_2 = sum(tile_n, na.rm=T), 
# 		three_ss_enrich_rep_2 = sum(exon_n, na.rm=T)/sum(tile_n, na.rm=T)) %>% 
# 	ungroup()
# group_C_bam2gr$splice_site_R1_norm$rep_3 <- group_C_bam2gr$final_R1_norm$rep_3 %>% 
# 	mutate(position_in_gene = exon_start) %>% 
# 	group_by(gene_name, position_in_gene) %>% summarise(
# 		sum_exon_n_rep_3 = sum(exon_n, na.rm=T), 
# 		sum_tile_n_rep_3 = sum(tile_n, na.rm=T), 
# 		three_ss_enrich_rep_3 = sum(exon_n, na.rm=T)/sum(tile_n, na.rm=T)) %>% 
# 	ungroup()

# group_C_bam2gr_ss_join <- full_join(group_C_bam2gr$splice_site_R1_norm$rep_1, full_join(group_C_bam2gr$splice_site_R1_norm$rep_2, group_C_bam2gr$splice_site_R1_norm$rep_3))
# group_C_bam2gr_ss_join <- gene_ranges_temp_tb %>% inner_join(group_C_bam2gr_ss_join) %>% 
# 	mutate(three_ss_enrich_mean = (sum_exon_n_rep_1+sum_exon_n_rep_2+sum_exon_n_rep_3)/(sum_tile_n_rep_1+sum_tile_n_rep_2+sum_tile_n_rep_3)) %>% 
# 	mutate(position_in_genome = ifelse(strand == "+", start-1+position_in_gene, end+1-position_in_gene))

# # save slice site enrichment scores
# write_tsv(group_C_bam2gr_ss_join, gzfile("../../results/group_C_gene_tiling_screen_3ss/Group_C_bam2gr_ss_join_updated.txt.gz"))

# # create splice site bed file
# group_C_bam2gr_ss_join_bed <- group_C_bam2gr_ss_join %>% 
# 	mutate(`#chrom` = seqnames) %>% 
# 	mutate(chromStart = position_in_genome-1-1+ifelse(strand=="+", -1, 2)) %>% 
# 	mutate(chromEnd = position_in_genome-1+ifelse(strand=="+", 0, 3)) %>% 
# 	filter(sum_tile_n_rep_1>=20, sum_tile_n_rep_2>=20, sum_tile_n_rep_3>=20) %>% 
# 	filter(sum_exon_n_rep_1>=20, sum_exon_n_rep_2>=20, sum_exon_n_rep_3>=20) %>% 
# 	# filter(three_ss_enrich_mean > 0.1) %>% 
# 	mutate(dataValue = three_ss_enrich_mean) %>% 
# 	dplyr::select(`#chrom`, chromStart, chromEnd, dataValue)

# write_tsv(group_C_bam2gr_ss_join_bed, "../../results/group_C_gene_tiling_screen_3ss/Group_C_scores_join_bed_updated.bg")
# file_temp <- file("../../results/group_C_gene_tiling_screen_3ss/Group_C_scores_join_bed_updated.bg", 'r+')
# writeLines(c("track type=bedGraph name=Tiling_score_3ss_updated description=Tiling_score_3ss_updated_enrichment visibility=display_mode color=215,0,0 altColor=0,0,215", readLines(file_temp)[-1]), con=file_temp)
# close(file_temp)

# compute read coverage RLE
# 	helper functions
extend_granges <- function(x, upstream=0, downstream=0) {
	# from https://support.bioconductor.org/p/78652/
	if (any(strand(x) == "*")) {
		warning("'*' ranges were treated as '+'")
	}
	on_plus <- strand(x) == "+" | strand(x) == "*"
	new_start <- start(x) - ifelse(on_plus, upstream, downstream)
	new_end <- end(x) + ifelse(on_plus, downstream, upstream)
	ranges(x) <- IRanges(new_start, new_end)
	return(trim(x))
}

group_C_incov_join <- c(group_C_bam2gr$in_R1_bam2fil$rep_1, group_C_bam2gr$in_R1_bam2fil$rep_2, group_C_bam2gr$in_R1_bam2fil$rep_3) %>% extend_granges(-149, 0)
group_C_incov_join <- coverage(group_C_incov_join) %>% GRanges() %>% as_tibble() %>% filter(score > 0)
names(group_C_incov_join) <- c("gene_name", "position_in_gene_start", "position_in_gene_end", "in_width", "in_strand", "in_coverage")

group_C_outcov_join <- c(group_C_bam2gr$out_R1_bam2fil$rep_1, group_C_bam2gr$out_R1_bam2fil$rep_2, group_C_bam2gr$out_R1_bam2fil$rep_3)
group_C_outcov_join <- coverage(group_C_outcov_join) %>% GRanges() %>% as_tibble() %>% filter(score > 0)
names(group_C_outcov_join) <- c("gene_name", "position_in_gene_start", "position_in_gene_end", "out_width", "out_strand", "out_coverage")

group_C_incov_join <-  gene_ranges_temp_tb %>% inner_join(group_C_incov_join) %>% 
	mutate(position_in_genome_start = ifelse(strand == "+", start-1+position_in_gene_start, end+1-position_in_gene_end)) %>% 
	mutate(position_in_genome_end = ifelse(strand == "+", start-1+position_in_gene_end, end+1-position_in_gene_start))

group_C_outcov_join <-  gene_ranges_temp_tb %>% inner_join(group_C_outcov_join) %>% 
	mutate(position_in_genome_start = ifelse(strand == "+", start-1+position_in_gene_start, end+1-position_in_gene_end)) %>% 
	mutate(position_in_genome_end = ifelse(strand == "+", start-1+position_in_gene_end, end+1-position_in_gene_start))

# create read coverage bed file
group_C_incov_join_bed <- group_C_incov_join %>% 
	mutate(`#chrom` = seqnames) %>% 
	mutate(chromStart = position_in_genome_start-1) %>% 
	mutate(chromEnd = position_in_genome_end) %>% 
	mutate(dataValue = in_coverage) %>% 
	dplyr::select(`#chrom`, chromStart, chromEnd, dataValue)
write_tsv(group_C_incov_join_bed, "../../results/group_C_gene_tiling_screen_3ss/Group_C_incov_join_bed_updated.bg")
file_temp <- file("../../results/group_C_gene_tiling_screen_3ss/Group_C_incov_join_bed_updated.bg", 'r+')
writeLines(c("track type=bedGraph name=Tiling_incov_3ss_updated description=Tiling_incov_3ss_updated_read_counts visibility=display_mode color=215,0,0 altColor=0,0,215", readLines(file_temp)[-1]), con=file_temp)
close(file_temp)

group_C_outcov_join_bed <- group_C_outcov_join %>% 
	mutate(`#chrom` = seqnames) %>% 
	mutate(chromStart = position_in_genome_start-1) %>% 
	mutate(chromEnd = position_in_genome_end) %>% 
	mutate(dataValue = out_coverage) %>% 
	dplyr::select(`#chrom`, chromStart, chromEnd, dataValue)
write_tsv(group_C_outcov_join_bed, "../../results/group_C_gene_tiling_screen_3ss/Group_C_outcov_join_bed_updated.bg")
file_temp <- file("../../results/group_C_gene_tiling_screen_3ss/Group_C_outcov_join_bed_updated.bg", 'r+')
writeLines(c("track type=bedGraph name=Tiling_outcov_3ss_updated description=Tiling_outcov_3ss_updated_read_counts visibility=display_mode color=215,0,0 altColor=0,0,215", readLines(file_temp)[-1]), con=file_temp)
close(file_temp)

# DEPRECATED
# # ggseqlogo
# up_window <- 30
# down_window <- 10
# y <- group_C_bam2gr_ss_join %>% 
# 	filter(sum_tile_n_rep_1>=20, sum_tile_n_rep_2>=20, sum_tile_n_rep_3>=20) %>% 
# 	filter(sum_exon_n_rep_1>=20, sum_exon_n_rep_2>=20, sum_exon_n_rep_3>=20) %>% 
# 	# filter(three_ss_enrich_mean > 0.1) %>% 
# 	rowwise() %>% mutate(sequence = getSeq(hg38, 
# 		names=seqnames, 
# 		start=ifelse(strand=="+", position_in_genome-up_window, position_in_genome-down_window),
# 		end=ifelse(strand=="+", position_in_genome+down_window, position_in_genome+up_window),
# 		strand=strand, as.character=TRUE)) %>% ungroup()
# ggseqlogo(y$sequence) + ylim(c(0, 2)) + 
# 	theme(aspect.ratio=0.5) + 
# 	scale_x_discrete(breaks=5*c(-4:2)+21, labels=5*c(-4:2), limits=5*c(-4:2)+21) 
# ggsave("../../results/group_C_gene_tiling_screen_3ss/Group_C_seqlogo_all_R1_3prime_updated.pdf")
