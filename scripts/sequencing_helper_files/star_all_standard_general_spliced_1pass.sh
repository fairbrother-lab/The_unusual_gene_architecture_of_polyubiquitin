#!/bin/sh

# STAR alignment for general experiments.

Index=$1
SJTab=$2
InDirectory=$3
OutDirectory=$4
Prefix=$5
Postfix=$6

echo $Index
echo $InDirectory
echo $OutDirectory
echo $Prefix
echo $Postfix

# star_align
STAR \
	--runThreadN 8 \
	--genomeDir $Index \
	--readFilesIn $InDirectory/$Prefix\_R1_001.fastq.gz $InDirectory/$Prefix\_R2_001.fastq.gz \
	--readFilesCommand zcat -c \
	--outSAMtype BAM Unsorted \
	--outFileNamePrefix $OutDirectory/star_align/$Postfix\_001.1pass. \
	--sjdbFileChrStartEnd $SJTab \
	--outFilterMismatchNmax 5 \
	--alignEndsType EndToEnd
