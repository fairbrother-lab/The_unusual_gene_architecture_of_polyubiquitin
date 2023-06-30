#!/bin/sh

# Postprocess STAR alignment for general experiments.

OutDirectory=$1
Postfix=$2

echo $OutDirectory
echo $Postfix

# star_unique
samtools view -@ 16 -hbq 10 $OutDirectory/star_align/$Postfix\_001.Aligned.out.bam >| $OutDirectory/star_unique/$Postfix\_001.Aligned.unique.out.bam

# star_sort
samtools sort -@ 16 -o $OutDirectory/star_sort/$Postfix\_001.Aligned.unique.sortedByCoord.out.bam $OutDirectory/star_unique/$Postfix\_001.Aligned.unique.out.bam
samtools index -@ 16 -b $OutDirectory/star_sort/$Postfix\_001.Aligned.unique.sortedByCoord.out.bam

# star_idxstats
samtools idxstats $OutDirectory/star_sort/$Postfix\_001.Aligned.unique.sortedByCoord.out.bam >| $OutDirectory/star_idxstats/$Postfix\_001.Aligned.unique.sortedByCoord.idxstats.txt

# star_coverage
bedtools genomecov -ibam $OutDirectory/star_sort/$Postfix\_001.Aligned.unique.sortedByCoord.out.bam -d | gzip >| $OutDirectory/star_coverage/$Postfix\_001.Aligned.unique.sortedByCoord.out.5to3prime.bedgraph.gz
bedtools genomecov -ibam $OutDirectory/star_sort/$Postfix\_001.Aligned.unique.sortedByCoord.out.bam -d -5 | gzip >| $OutDirectory/star_coverage/$Postfix\_001.Aligned.unique.sortedByCoord.out.5prime.bedgraph.gz
bedtools genomecov -ibam $OutDirectory/star_sort/$Postfix\_001.Aligned.unique.sortedByCoord.out.bam -d -3 | gzip >| $OutDirectory/star_coverage/$Postfix\_001.Aligned.unique.sortedByCoord.out.3prime.bedgraph.gz
