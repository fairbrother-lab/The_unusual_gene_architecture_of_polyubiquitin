#!/bin/sh

# Create STAR index files.


# Group A aprt barcoded

# 	unzip fastas
gunzip -fkv ../data/custom_reference/group_A_aprt_barcoded/*.fasta.gz

# create star index files
STAR \
	--runThreadN 32 \
	--runMode genomeGenerate \
	--genomeDir ../data/custom_star_index/group_A_aprt_barcoded_input \
	--genomeFastaFiles ../data/custom_reference/group_A_aprt_barcoded/group_A_aprt_barcoded_input.fasta \
	--genomeSAindexNbases 8 \
	--genomeChrBinNbits 8

STAR \
	--runThreadN 32 \
	--runMode genomeGenerate \
	--genomeDir ../data/custom_star_index/group_A_aprt_barcoded_output \
	--genomeFastaFiles ../data/custom_reference/group_A_aprt_barcoded/group_A_aprt_barcoded_output.fasta \
	--genomeSAindexNbases 8 \
	--genomeChrBinNbits 8

STAR \
	--runThreadN 32 \
	--runMode genomeGenerate \
	--genomeDir ../data/custom_star_index/group_A_aprt_barcoded_left \
	--genomeFastaFiles ../data/custom_reference/group_A_aprt_barcoded/group_A_aprt_barcoded_left.fasta \
	--genomeSAindexNbases 8 \
	--genomeChrBinNbits 8

STAR \
	--runThreadN 32 \
	--runMode genomeGenerate \
	--genomeDir ../data/custom_star_index/group_A_aprt_barcoded_right \
	--genomeFastaFiles ../data/custom_reference/group_A_aprt_barcoded/group_A_aprt_barcoded_right.fasta \
	--genomeSAindexNbases 8 \
	--genomeChrBinNbits 8

# 	added 2021-10-20
cat ../data/custom_reference/group_A_aprt_barcoded/group_A_aprt_barcoded_input.fasta \
	../data/custom_reference/group_A_aprt_barcoded/group_A_aprt_barcoded_output.fasta >| \
	../data/custom_reference/group_A_aprt_barcoded/group_A_aprt_barcoded_unspliced.fasta

STAR \
	--runThreadN 32 \
	--runMode genomeGenerate \
	--genomeDir ../data/custom_star_index/group_A_aprt_barcoded_unspliced \
	--genomeFastaFiles ../data/custom_reference/group_A_aprt_barcoded/group_A_aprt_barcoded_unspliced.fasta \
	--genomeSAindexNbases 8 \
	--genomeChrBinNbits 8


# Group B three prime geisinger splicing species
gunzip -fkv ../data/custom_reference/group_B_three_prime_geisinger_splicing_species/*.fasta.gz

# create star index files
STAR \
	--runThreadN 32 \
	--runMode genomeGenerate \
	--genomeDir ../data/custom_star_index/group_B_three_prime_geisinger_splicing_species_input \
	--genomeFastaFiles ../data/custom_reference/group_B_three_prime_geisinger_splicing_species/group_B_three_prime_geisinger_splicing_species_input.fasta \
	--genomeSAindexNbases 8 \
	--genomeChrBinNbits 8

STAR \
	--runThreadN 32 \
	--runMode genomeGenerate \
	--genomeDir ../data/custom_star_index/group_B_three_prime_geisinger_splicing_species_output \
	--genomeFastaFiles ../data/custom_reference/group_B_three_prime_geisinger_splicing_species/group_B_three_prime_geisinger_splicing_species_output.fasta \
	--genomeSAindexNbases 8 \
	--genomeChrBinNbits 8


# Group C gene tiling screen 3ss
gunzip -fkv ../data/custom_reference/group_C_gene_tiling_screen_3ss/*.fasta.gz

# create star index files
STAR \
	--runThreadN 32 \
	--runMode genomeGenerate \
	--genomeDir ../data/custom_star_index/group_C_gene_tiling_screen_3ss_input \
	--genomeFastaFiles ../data/custom_reference/group_C_gene_tiling_screen_3ss/group_C_gene_tiling_screen_3ss_input.fasta \
	--genomeSAindexNbases 8 \
	--genomeChrBinNbits 8

STAR \
	--runThreadN 32 \
	--runMode genomeGenerate \
	--genomeDir ../data/custom_star_index/group_C_gene_tiling_screen_3ss_output \
	--genomeFastaFiles ../data/custom_reference/group_C_gene_tiling_screen_3ss/group_C_gene_tiling_screen_3ss_output.fasta \
	--genomeSAindexNbases 8 \
	--genomeChrBinNbits 8


# Group D three prime geisinger splice site
gunzip -fkv ../data/custom_reference/group_D_three_prime_geisinger_splice_site/*.fasta.gz

# create star index files
STAR \
	--runThreadN 32 \
	--runMode genomeGenerate \
	--genomeDir ../data/custom_star_index/group_D_three_prime_geisinger_splice_site_input \
	--genomeFastaFiles ../data/custom_reference/group_D_three_prime_geisinger_splice_site/group_D_three_prime_geisinger_splice_site_input.fasta \
	--genomeSAindexNbases 8 \
	--genomeChrBinNbits 8

STAR \
	--runThreadN 32 \
	--runMode genomeGenerate \
	--genomeDir ../data/custom_star_index/group_D_three_prime_geisinger_splice_site_output \
	--genomeFastaFiles ../data/custom_reference/group_D_three_prime_geisinger_splice_site/group_D_three_prime_geisinger_splice_site_output.fasta \
	--genomeSAindexNbases 7 \
	--genomeChrBinNbits 7


# Group E five prime geisinger splicing species
gunzip -fkv ../data/custom_reference/group_E_five_prime_geisinger_splicing_species/*.fasta.gz

# create star index files
STAR \
	--runThreadN 32 \
	--runMode genomeGenerate \
	--genomeDir ../data/custom_star_index/group_E_five_prime_geisinger_splicing_species_input \
	--genomeFastaFiles ../data/custom_reference/group_E_five_prime_geisinger_splicing_species/group_E_five_prime_geisinger_splicing_species_input.fasta \
	--genomeSAindexNbases 8 \
	--genomeChrBinNbits 8

STAR \
	--runThreadN 32 \
	--runMode genomeGenerate \
	--genomeDir ../data/custom_star_index/group_E_five_prime_geisinger_splicing_species_output \
	--genomeFastaFiles ../data/custom_reference/group_E_five_prime_geisinger_splicing_species/group_E_five_prime_geisinger_splicing_species_output.fasta \
	--genomeSAindexNbases 8 \
	--genomeChrBinNbits 8


# Group F gene tiling screen 5ss
gunzip -fkv ../data/custom_reference/group_F_gene_tiling_screen_5ss/*.fasta.gz

# create star index files
STAR \
	--runThreadN 32 \
	--runMode genomeGenerate \
	--genomeDir ../data/custom_star_index/group_F_gene_tiling_screen_5ss_input \
	--genomeFastaFiles ../data/custom_reference/group_F_gene_tiling_screen_5ss/group_F_gene_tiling_screen_5ss_input.fasta \
	--genomeSAindexNbases 8 \
	--genomeChrBinNbits 8

STAR \
	--runThreadN 32 \
	--runMode genomeGenerate \
	--genomeDir ../data/custom_star_index/group_F_gene_tiling_screen_5ss_output \
	--genomeFastaFiles ../data/custom_reference/group_F_gene_tiling_screen_5ss/group_F_gene_tiling_screen_5ss_output.fasta \
	--genomeSAindexNbases 7 \
	--genomeChrBinNbits 7


# Group contam analysis
gunzip -fkv ../data/custom_reference/group_contam_analysis/*.fasta.gz

# create star index files
STAR \
	--runThreadN 32 \
	--runMode genomeGenerate \
	--genomeDir ../data/custom_star_index/group_contam_analysis_input \
	--genomeFastaFiles ../data/custom_reference/group_contam_analysis/group_contam_analysis_input.fasta \
	--genomeSAindexNbases 8 \
	--genomeChrBinNbits 8

STAR \
	--runThreadN 32 \
	--runMode genomeGenerate \
	--genomeDir ../data/custom_star_index/group_contam_analysis_output \
	--genomeFastaFiles ../data/custom_reference/group_contam_analysis/group_contam_analysis_output.fasta \
	--genomeSAindexNbases 8 \
	--genomeChrBinNbits 8


# Group D separated libraries
gunzip -fkv ../data/custom_reference/group_D_three_prime_geisinger_splice_site/*.fasta.gz

# create star index files
STAR \
	--runThreadN 32 \
	--runMode genomeGenerate \
	--genomeDir ../data/custom_star_index/group_D_three_prime_geisinger_splice_site_lib1_input \
	--genomeFastaFiles ../data/custom_reference/group_D_three_prime_geisinger_splice_site/group_D_three_prime_geisinger_splice_site_lib1_input.fasta \
	--genomeSAindexNbases 8 \
	--genomeChrBinNbits 8

STAR \
	--runThreadN 32 \
	--runMode genomeGenerate \
	--genomeDir ../data/custom_star_index/group_D_three_prime_geisinger_splice_site_lib1_output \
	--genomeFastaFiles ../data/custom_reference/group_D_three_prime_geisinger_splice_site/group_D_three_prime_geisinger_splice_site_lib1_output.fasta \
	--genomeSAindexNbases 7 \
	--genomeChrBinNbits 7

STAR \
	--runThreadN 32 \
	--runMode genomeGenerate \
	--genomeDir ../data/custom_star_index/group_D_three_prime_geisinger_splice_site_lib2_input \
	--genomeFastaFiles ../data/custom_reference/group_D_three_prime_geisinger_splice_site/group_D_three_prime_geisinger_splice_site_lib2_input.fasta \
	--genomeSAindexNbases 8 \
	--genomeChrBinNbits 8

STAR \
	--runThreadN 32 \
	--runMode genomeGenerate \
	--genomeDir ../data/custom_star_index/group_D_three_prime_geisinger_splice_site_lib2_output \
	--genomeFastaFiles ../data/custom_reference/group_D_three_prime_geisinger_splice_site/group_D_three_prime_geisinger_splice_site_lib2_output.fasta \
	--genomeSAindexNbases 7 \
	--genomeChrBinNbits 7

STAR \
	--runThreadN 32 \
	--runMode genomeGenerate \
	--genomeDir ../data/custom_star_index/group_D_three_prime_geisinger_splice_site_lib3_input \
	--genomeFastaFiles ../data/custom_reference/group_D_three_prime_geisinger_splice_site/group_D_three_prime_geisinger_splice_site_lib3_input.fasta \
	--genomeSAindexNbases 8 \
	--genomeChrBinNbits 8

STAR \
	--runThreadN 32 \
	--runMode genomeGenerate \
	--genomeDir ../data/custom_star_index/group_D_three_prime_geisinger_splice_site_lib3_output \
	--genomeFastaFiles ../data/custom_reference/group_D_three_prime_geisinger_splice_site/group_D_three_prime_geisinger_splice_site_lib3_output.fasta \
	--genomeSAindexNbases 7 \
	--genomeChrBinNbits 7
