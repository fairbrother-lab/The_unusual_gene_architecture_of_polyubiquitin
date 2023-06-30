#!/bin/sh

# Count by grep

# preamble
Node=node01
InDirectory=/datasets2/lab_sequencing/Stephen_Chaorui_experiments/30-585341847/00_fastq
OutDirectory=../../data/group_C_gene_tiling_screen_3ss

# input
# bbmerge.sh in1=$InDirectory/GroupC-input-1_R1_001.fastq.gz in2=$InDirectory/GroupC-input-2_R1_001.fastq.gz out=$OutDirectory/grep_fastq/GroupC-input-1_merged_001.fastq.gz outu1=$OutDirectory/grep_fastq/GroupC-input-1_unmerged1_001.fastq.gz outu2=$OutDirectory/grep_fastq/GroupC-input-1_unmerged2_001.fastq.gz
# bbmerge.sh in1=$InDirectory/GroupC-input-2_R1_001.fastq.gz in2=$InDirectory/GroupC-input-2_R2_001.fastq.gz out=$OutDirectory/grep_fastq/GroupC-input-2_merged_001.fastq.gz outu1=$OutDirectory/grep_fastq/GroupC-input-2_unmerged1_001.fastq.gz outu2=$OutDirectory/grep_fastq/GroupC-input-2_unmerged2_001.fastq.gz
# bbmerge.sh in1=$InDirectory/GroupC-input-3_R1_001.fastq.gz in2=$InDirectory/GroupC-input-3_R2_001.fastq.gz out=$OutDirectory/grep_fastq/GroupC-input-3_merged_001.fastq.gz outu1=$OutDirectory/grep_fastq/GroupC-input-3_unmerged1_001.fastq.gz outu2=$OutDirectory/grep_fastq/GroupC-input-3_unmerged2_001.fastq.gz

# # output
# bbmerge.sh in1=$InDirectory/GroupC-output-1_R1_001.fastq.gz in2=$InDirectory/GroupC-output-2_R1_001.fastq.gz out=$OutDirectory/grep_fastq/GroupC-output-1_merged_001.fastq.gz outu1=$OutDirectory/grep_fastq/GroupC-output-1_unmerged1_001.fastq.gz outu2=$OutDirectory/grep_fastq/GroupC-output-1_unmerged2_001.fastq.gz
# bbmerge.sh in1=$InDirectory/GroupC-output-2_R1_001.fastq.gz in2=$InDirectory/GroupC-output-2_R2_001.fastq.gz out=$OutDirectory/grep_fastq/GroupC-output-2_merged_001.fastq.gz outu1=$OutDirectory/grep_fastq/GroupC-output-2_unmerged1_001.fastq.gz outu2=$OutDirectory/grep_fastq/GroupC-output-2_unmerged2_001.fastq.gz
# bbmerge.sh in1=$InDirectory/GroupC-output-3_R1_001.fastq.gz in2=$InDirectory/GroupC-output-3_R2_001.fastq.gz out=$OutDirectory/grep_fastq/GroupC-output-3_merged_001.fastq.gz outu1=$OutDirectory/grep_fastq/GroupC-output-3_unmerged1_001.fastq.gz outu2=$OutDirectory/grep_fastq/GroupC-output-3_unmerged2_001.fastq.gz

# input
# echo 'grep GroupC-input-1_merged_001'
# printf "\043\041/bin/sh\\ngunzip -cd $OutDirectory/grep_fastq/GroupC-input-1_merged_001.fastq.gz | seqkit grep -srp 'CAGGCTATAG.*GCTTTTCCAC' | seqkit amplicon -F CAGGCTATAG -R GTGGAAAAGC -r 11:-11 | bgzip >| $OutDirectory/grep_fastq/GroupC-input-grep-1_merged_001.fastq.gz  # right" >| GroupC-input-grep-1_merged_001.sh
# echo 'grep GroupC-input-2_merged_001'
# printf "\043\041/bin/sh\\ngunzip -cd $OutDirectory/grep_fastq/GroupC-input-2_merged_001.fastq.gz | seqkit grep -srp 'CAGGCTATAG.*GCTTTTCCAC' | seqkit amplicon -F CAGGCTATAG -R GTGGAAAAGC -r 11:-11 | bgzip >| $OutDirectory/grep_fastq/GroupC-input-grep-2_merged_001.fastq.gz  # right" >| GroupC-input-grep-2_merged_001.sh
# echo 'grep GroupC-input-3_merged_001'
# printf "\043\041/bin/sh\\ngunzip -cd $OutDirectory/grep_fastq/GroupC-input-3_merged_001.fastq.gz | seqkit grep -srp 'CAGGCTATAG.*GCTTTTCCAC' | seqkit amplicon -F CAGGCTATAG -R GTGGAAAAGC -r 11:-11 | bgzip >| $OutDirectory/grep_fastq/GroupC-input-grep-3_merged_001.fastq.gz  # right" >| GroupC-input-grep-3_merged_001.sh

echo 'grep GroupC-input-1_R1_001'
printf "\043\041/bin/sh\\ngunzip -cd $InDirectory/GroupC-input-1_R1_001.fastq.gz | seqkit grep -sp 'CAGGCTATAG' | sed '2~2 s/$/AAAAACCCCCTTTTTGGGGG/' | seqkit amplicon -F CAGGCTATAG -R CCCCCAAAAAGGGGGTTTTT -r 11:-21 | bgzip >| $OutDirectory/grep_fastq/GroupC-input-grep-1_R1_001.fastq.gz  # right" >| GroupC-input-grep-1_R1_001.sh
echo 'grep GroupC-input-2_R1_001'
printf "\043\041/bin/sh\\ngunzip -cd $InDirectory/GroupC-input-2_R1_001.fastq.gz | seqkit grep -sp 'CAGGCTATAG' | sed '2~2 s/$/AAAAACCCCCTTTTTGGGGG/' | seqkit amplicon -F CAGGCTATAG -R CCCCCAAAAAGGGGGTTTTT -r 11:-21 | bgzip >| $OutDirectory/grep_fastq/GroupC-input-grep-2_R1_001.fastq.gz  # right" >| GroupC-input-grep-2_R1_001.sh
echo 'grep GroupC-input-3_R1_001'
printf "\043\041/bin/sh\\ngunzip -cd $InDirectory/GroupC-input-3_R1_001.fastq.gz | seqkit grep -sp 'CAGGCTATAG' | sed '2~2 s/$/AAAAACCCCCTTTTTGGGGG/' | seqkit amplicon -F CAGGCTATAG -R CCCCCAAAAAGGGGGTTTTT -r 11:-21 | bgzip >| $OutDirectory/grep_fastq/GroupC-input-grep-3_R1_001.fastq.gz  # right" >| GroupC-input-grep-3_R1_001.sh

echo 'grep GroupC-input-1_R2_001'
printf "\043\041/bin/sh\\ngunzip -cd $InDirectory/GroupC-input-1_R2_001.fastq.gz | seqkit grep -sp 'GTGGAAAAGC' | sed '2~2 s/$/AAAAACCCCCTTTTTGGGGG/' | seqkit amplicon -F GTGGAAAAGC -R CCCCCAAAAAGGGGGTTTTT -r 11:-21 | bgzip >| $OutDirectory/grep_fastq/GroupC-input-grep-1_R2_001.fastq.gz  # right" >| GroupC-input-grep-1_R2_001.sh
echo 'grep GroupC-input-2_R2_001'
printf "\043\041/bin/sh\\ngunzip -cd $InDirectory/GroupC-input-2_R2_001.fastq.gz | seqkit grep -sp 'GTGGAAAAGC' | sed '2~2 s/$/AAAAACCCCCTTTTTGGGGG/' | seqkit amplicon -F GTGGAAAAGC -R CCCCCAAAAAGGGGGTTTTT -r 11:-21 | bgzip >| $OutDirectory/grep_fastq/GroupC-input-grep-2_R2_001.fastq.gz  # right" >| GroupC-input-grep-2_R2_001.sh
echo 'grep GroupC-input-3_R2_001'
printf "\043\041/bin/sh\\ngunzip -cd $InDirectory/GroupC-input-3_R2_001.fastq.gz | seqkit grep -sp 'GTGGAAAAGC' | sed '2~2 s/$/AAAAACCCCCTTTTTGGGGG/' | seqkit amplicon -F GTGGAAAAGC -R CCCCCAAAAAGGGGGTTTTT -r 11:-21 | bgzip >| $OutDirectory/grep_fastq/GroupC-input-grep-3_R2_001.fastq.gz  # right" >| GroupC-input-grep-3_R2_001.sh

# output
echo 'grep GroupC-output-1_R1_001'
printf "\043\041/bin/sh\\ngunzip -cd $InDirectory/GroupC-output-1_R1_001.fastq.gz | seqkit grep -srp 'AGCTGTTGGG.*GCTTTTCCAC' | seqkit amplicon -F AGCTGTTGGG -R GTGGAAAAGC -r 11:-11 | seqkit seq -m 31 | bgzip >| $OutDirectory/grep_fastq/GroupC-output-grep-1_R1_001.fastq.gz  # right" >| GroupC-output-grep-1_R1_001.sh
echo 'grep GroupC-output-2_R1_001'
printf "\043\041/bin/sh\\ngunzip -cd $InDirectory/GroupC-output-2_R1_001.fastq.gz | seqkit grep -srp 'AGCTGTTGGG.*GCTTTTCCAC' | seqkit amplicon -F AGCTGTTGGG -R GTGGAAAAGC -r 11:-11 | seqkit seq -m 31 | bgzip >| $OutDirectory/grep_fastq/GroupC-output-grep-2_R1_001.fastq.gz  # right" >| GroupC-output-grep-2_R1_001.sh
echo 'grep GroupC-output-3_R1_001'
printf "\043\041/bin/sh\\ngunzip -cd $InDirectory/GroupC-output-3_R1_001.fastq.gz | seqkit grep -srp 'AGCTGTTGGG.*GCTTTTCCAC' | seqkit amplicon -F AGCTGTTGGG -R GTGGAAAAGC -r 11:-11 | seqkit seq -m 31 | bgzip >| $OutDirectory/grep_fastq/GroupC-output-grep-3_R1_001.fastq.gz  # right" >| GroupC-output-grep-3_R1_001.sh

# # output
# echo 'grep GroupC-output-1_R1_001'
# printf "\043\041/bin/sh\\ngunzip -cd $InDirectory/GroupC-output-1_R1_001.fastq.gz | seqkit grep -srp 'AGCTGTTGGG.*GCTTTTCCAC' | seqkit amplicon -F AGCTGTTGGG -R GTGGAAAAGC -r 11:-11 | seqkit seq -m 31 >| $OutDirectory/grep_fastq/GroupC-output-grep-1_R1_001_temp1.fastq # right\\ngunzip -cd $InDirectory/GroupC-output-1_R1_001.fastq.gz | seqkit grep -srp 'AGCTGTTGGG' | seqkit grep -m 2 -svp 'GCTTTTCCAC' | sed '2~2 s/$/AAAAACCCCCTTTTTGGGGG/' | seqkit amplicon -F AGCTGTTGGG -R CCCCCAAAAAGGGGGTTTTT -r 11:-21 | seqkit seq -m 31 >| $OutDirectory/grep_fastq/GroupC-output-grep-1_R1_001_temp2.fastq\\ncat $OutDirectory/grep_fastq/GroupC-output-grep-1_R1_001_temp1.fastq $OutDirectory/grep_fastq/GroupC-output-grep-1_R1_001_temp2.fastq | bgzip >| $OutDirectory/grep_fastq/GroupC-output-grep-1_R1_001.fastq.gz" >| GroupC-output-grep-1_R1_001.sh
# echo 'grep GroupC-output-2_R1_001'
# printf "\043\041/bin/sh\\ngunzip -cd $InDirectory/GroupC-output-2_R1_001.fastq.gz | seqkit grep -srp 'AGCTGTTGGG.*GCTTTTCCAC' | seqkit amplicon -F AGCTGTTGGG -R GTGGAAAAGC -r 11:-11 | seqkit seq -m 31 >| $OutDirectory/grep_fastq/GroupC-output-grep-2_R1_001_temp1.fastq # right\\ngunzip -cd $InDirectory/GroupC-output-2_R1_001.fastq.gz | seqkit grep -srp 'AGCTGTTGGG' | seqkit grep -m 2 -svp 'GCTTTTCCAC' | sed '2~2 s/$/AAAAACCCCCTTTTTGGGGG/' | seqkit amplicon -F AGCTGTTGGG -R CCCCCAAAAAGGGGGTTTTT -r 11:-21 | seqkit seq -m 31 >| $OutDirectory/grep_fastq/GroupC-output-grep-2_R1_001_temp2.fastq\\ncat $OutDirectory/grep_fastq/GroupC-output-grep-2_R1_001_temp1.fastq $OutDirectory/grep_fastq/GroupC-output-grep-2_R1_001_temp2.fastq | bgzip >| $OutDirectory/grep_fastq/GroupC-output-grep-2_R1_001.fastq.gz" >| GroupC-output-grep-2_R1_001.sh
# echo 'grep GroupC-output-3_R1_001'
# printf "\043\041/bin/sh\\ngunzip -cd $InDirectory/GroupC-output-2_R1_001.fastq.gz | seqkit grep -srp 'AGCTGTTGGG.*GCTTTTCCAC' | seqkit amplicon -F AGCTGTTGGG -R GTGGAAAAGC -r 11:-11 | seqkit seq -m 31 >| $OutDirectory/grep_fastq/GroupC-output-grep-3_R1_001_temp1.fastq # right\\ngunzip -cd $InDirectory/GroupC-output-3_R1_001.fastq.gz | seqkit grep -srp 'AGCTGTTGGG' | seqkit grep -m 2 -svp 'GCTTTTCCAC' | sed '2~2 s/$/AAAAACCCCCTTTTTGGGGG/' | seqkit amplicon -F AGCTGTTGGG -R CCCCCAAAAAGGGGGTTTTT -r 11:-21 | seqkit seq -m 31 >| $OutDirectory/grep_fastq/GroupC-output-grep-3_R1_001_temp2.fastq\\ncat $OutDirectory/grep_fastq/GroupC-output-grep-3_R1_001_temp1.fastq $OutDirectory/grep_fastq/GroupC-output-grep-3_R1_001_temp2.fastq | bgzip >| $OutDirectory/grep_fastq/GroupC-output-grep-3_R1_001.fastq.gz" >| GroupC-output-grep-3_R1_001.sh

# reverse reads are uninformative
# sbatch GroupC-input-grep-1_merged_001.sh
# sbatch GroupC-input-grep-2_merged_001.sh
# sbatch GroupC-input-grep-3_merged_001.sh
sbatch GroupC-input-grep-1_R1_001.sh
sbatch GroupC-input-grep-2_R1_001.sh
sbatch GroupC-input-grep-3_R1_001.sh
sbatch GroupC-input-grep-2_R1_001.sh
sbatch GroupC-input-grep-2_R2_001.sh
sbatch GroupC-input-grep-3_R2_001.sh
sbatch GroupC-output-grep-1_R1_001.sh
sbatch GroupC-output-grep-2_R1_001.sh
sbatch GroupC-output-grep-3_R1_001.sh
