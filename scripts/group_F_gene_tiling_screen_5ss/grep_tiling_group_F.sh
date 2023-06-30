#!/bin/sh

# Count by grep

# preamble
Node=node01
InDirectory=/datasets2/lab_sequencing/Stephen_Chaorui_experiments/30-585341847/00_fastq
OutDirectory=../../data/group_F_gene_tiling_screen_5ss

# input
# bbmerge.sh in1=$InDirectory/GroupF-input-1_R1_001.fastq.gz in2=$InDirectory/GroupF-input-1_R2_001.fastq.gz out=$OutDirectory/grep_fastq/GroupF-input-1_merged_001.fastq.gz outu1=$OutDirectory/grep_fastq/GroupF-input-1_unmerged1_001.fastq.gz outu2=$OutDirectory/grep_fastq/GroupF-input-1_unmerged2_001.fastq.gz
# bbmerge.sh in1=$InDirectory/GroupF-input-2_R1_001.fastq.gz in2=$InDirectory/GroupF-input-2_R2_001.fastq.gz out=$OutDirectory/grep_fastq/GroupF-input-2_merged_001.fastq.gz outu1=$OutDirectory/grep_fastq/GroupF-input-2_unmerged1_001.fastq.gz outu2=$OutDirectory/grep_fastq/GroupF-input-2_unmerged2_001.fastq.gz
# bbmerge.sh in1=$InDirectory/GroupF-input-3_R1_001.fastq.gz in2=$InDirectory/GroupF-input-3_R2_001.fastq.gz out=$OutDirectory/grep_fastq/GroupF-input-3_merged_001.fastq.gz outu1=$OutDirectory/grep_fastq/GroupF-input-3_unmerged1_001.fastq.gz outu2=$OutDirectory/grep_fastq/GroupF-input-3_unmerged2_001.fastq.gz

# # output
# bbmerge.sh in1=$InDirectory/GroupF-output-1_R1_001.fastq.gz in2=$InDirectory/GroupF-output-1_R2_001.fastq.gz out=$OutDirectory/grep_fastq/GroupF-output-1_merged_001.fastq.gz outu1=$OutDirectory/grep_fastq/GroupF-output-1_unmerged1_001.fastq.gz outu2=$OutDirectory/grep_fastq/GroupF-output-1_unmerged2_001.fastq.gz
# bbmerge.sh in1=$InDirectory/GroupF-output-2_R1_001.fastq.gz in2=$InDirectory/GroupF-output-2_R2_001.fastq.gz out=$OutDirectory/grep_fastq/GroupF-output-2_merged_001.fastq.gz outu1=$OutDirectory/grep_fastq/GroupF-output-2_unmerged1_001.fastq.gz outu2=$OutDirectory/grep_fastq/GroupF-output-2_unmerged2_001.fastq.gz
# bbmerge.sh in1=$InDirectory/GroupF-output-3_R1_001.fastq.gz in2=$InDirectory/GroupF-output-3_R2_001.fastq.gz out=$OutDirectory/grep_fastq/GroupF-output-3_merged_001.fastq.gz outu1=$OutDirectory/grep_fastq/GroupF-output-3_unmerged1_001.fastq.gz outu2=$OutDirectory/grep_fastq/GroupF-output-3_unmerged2_001.fastq.gz

# input
# echo 'grep GroupF-input-1_merged_001'
# printf "\043\041/bin/sh\\ngunzip -cd $OutDirectory/grep_fastq/GroupF-input-1_merged_001.fastq.gz | grep -i 'CAGGCTATAG.*GCTTTTCCAC' --no-group-separator -B 1 -A 2 | seqkit amplicon -F CAGGCTATAG -R GTGGAAAAGC -r 11:-11 | bgzip >| $OutDirectory/grep_fastq/GroupF-input-grep-1_merged_001.fastq.gz  # right" >| GroupF-input-grep-1_merged_001.sh
# echo 'grep GroupF-input-2_merged_001'
# printf "\043\041/bin/sh\\ngunzip -cd $OutDirectory/grep_fastq/GroupF-input-2_merged_001.fastq.gz | grep -i 'CAGGCTATAG.*GCTTTTCCAC' --no-group-separator -B 1 -A 2 | seqkit amplicon -F CAGGCTATAG -R GTGGAAAAGC -r 11:-11 | bgzip >| $OutDirectory/grep_fastq/GroupF-input-grep-2_merged_001.fastq.gz  # right" >| GroupF-input-grep-2_merged_001.sh
# echo 'grep GroupF-input-3_merged_001'
# printf "\043\041/bin/sh\\ngunzip -cd $OutDirectory/grep_fastq/GroupF-input-3_merged_001.fastq.gz | grep -i 'CAGGCTATAG.*GCTTTTCCAC' --no-group-separator -B 1 -A 2 | seqkit amplicon -F CAGGCTATAG -R GTGGAAAAGC -r 11:-11 | bgzip >| $OutDirectory/grep_fastq/GroupF-input-grep-3_merged_001.fastq.gz  # right" >| GroupF-input-grep-3_merged_001.sh

echo 'grep GroupF-input-1_R1_001'
printf "\043\041/bin/sh\\ngunzip -cd $InDirectory/GroupF-input-1_R1_001.fastq.gz | grep -i 'CAGGCTATAG' --no-group-separator -B 1 -A 2 | sed '2~2 s/$/AAAAACCCCCTTTTTGGGGG/' | seqkit amplicon -F CAGGCTATAG -R CCCCCAAAAAGGGGGTTTTT -r 11:-21 | bgzip >| $OutDirectory/grep_fastq/GroupF-input-grep-1_R1_001.fastq.gz  # right" >| GroupF-input-grep-1_R1_001.sh
echo 'grep GroupF-input-2_R1_001'
printf "\043\041/bin/sh\\ngunzip -cd $InDirectory/GroupF-input-2_R1_001.fastq.gz | grep -i 'CAGGCTATAG' --no-group-separator -B 1 -A 2 | sed '2~2 s/$/AAAAACCCCCTTTTTGGGGG/' | seqkit amplicon -F CAGGCTATAG -R CCCCCAAAAAGGGGGTTTTT -r 11:-21 | bgzip >| $OutDirectory/grep_fastq/GroupF-input-grep-2_R1_001.fastq.gz  # right" >| GroupF-input-grep-2_R1_001.sh
echo 'grep GroupF-input-3_R1_001'
printf "\043\041/bin/sh\\ngunzip -cd $InDirectory/GroupF-input-3_R1_001.fastq.gz | grep -i 'CAGGCTATAG' --no-group-separator -B 1 -A 2 | sed '2~2 s/$/AAAAACCCCCTTTTTGGGGG/' | seqkit amplicon -F CAGGCTATAG -R CCCCCAAAAAGGGGGTTTTT -r 11:-21 | bgzip >| $OutDirectory/grep_fastq/GroupF-input-grep-3_R1_001.fastq.gz  # right" >| GroupF-input-grep-3_R1_001.sh

echo 'grep GroupF-input-1_R2_001'
printf "\043\041/bin/sh\\ngunzip -cd $InDirectory/GroupF-input-1_R2_001.fastq.gz | grep -i 'GTGGAAAAGC' --no-group-separator -B 1 -A 2 | sed '2~2 s/$/AAAAACCCCCTTTTTGGGGG/' | seqkit amplicon -F GTGGAAAAGC -R CCCCCAAAAAGGGGGTTTTT -r 11:-21 | bgzip >| $OutDirectory/grep_fastq/GroupF-input-grep-1_R2_001.fastq.gz  # right" >| GroupF-input-grep-1_R2_001.sh
echo 'grep GroupF-input-2_R2_001'
printf "\043\041/bin/sh\\ngunzip -cd $InDirectory/GroupF-input-2_R2_001.fastq.gz | grep -i 'GTGGAAAAGC' --no-group-separator -B 1 -A 2 | sed '2~2 s/$/AAAAACCCCCTTTTTGGGGG/' | seqkit amplicon -F GTGGAAAAGC -R CCCCCAAAAAGGGGGTTTTT -r 11:-21 | bgzip >| $OutDirectory/grep_fastq/GroupF-input-grep-2_R2_001.fastq.gz  # right" >| GroupF-input-grep-2_R2_001.sh
echo 'grep GroupF-input-3_R2_001'
printf "\043\041/bin/sh\\ngunzip -cd $InDirectory/GroupF-input-3_R2_001.fastq.gz | grep -i 'GTGGAAAAGC' --no-group-separator -B 1 -A 2 | sed '2~2 s/$/AAAAACCCCCTTTTTGGGGG/' | seqkit amplicon -F GTGGAAAAGC -R CCCCCAAAAAGGGGGTTTTT -r 11:-21 | bgzip >| $OutDirectory/grep_fastq/GroupF-input-grep-3_R2_001.fastq.gz  # right" >| GroupF-input-grep-3_R2_001.sh

# output
echo 'grep GroupF-output-1_R1_001'
printf "\043\041/bin/sh\\ngunzip -cd $InDirectory/GroupF-output-1_R1_001.fastq.gz | seqkit grep -srp 'CAGGCTATAG.*GTGCGGCAGC' | seqkit amplicon -F CAGGCTATAG -R GCTGCCGCAC -r 11:-11 | seqkit seq -m 31 | bgzip >| $OutDirectory/grep_fastq/GroupF-output-grep-1_R1_001.fastq.gz  # right" >| GroupF-output-grep-1_R1_001.sh
echo 'grep GroupF-output-2_R1_001'
printf "\043\041/bin/sh\\ngunzip -cd $InDirectory/GroupF-output-2_R1_001.fastq.gz | seqkit grep -srp 'CAGGCTATAG.*GTGCGGCAGC' | seqkit amplicon -F CAGGCTATAG -R GCTGCCGCAC -r 11:-11 | seqkit seq -m 31 | bgzip >| $OutDirectory/grep_fastq/GroupF-output-grep-2_R1_001.fastq.gz  # right" >| GroupF-output-grep-2_R1_001.sh
echo 'grep GroupF-output-3_R1_001'
printf "\043\041/bin/sh\\ngunzip -cd $InDirectory/GroupF-output-3_R1_001.fastq.gz | seqkit grep -srp 'CAGGCTATAG.*GTGCGGCAGC' | seqkit amplicon -F CAGGCTATAG -R GCTGCCGCAC -r 11:-11 | seqkit seq -m 31 | bgzip >| $OutDirectory/grep_fastq/GroupF-output-grep-3_R1_001.fastq.gz  # right" >| GroupF-output-grep-3_R1_001.sh

# # output
# echo 'grep GroupF-output-1_R1_001'
# printf "\043\041/bin/sh\\ngunzip -cd $InDirectory/GroupF-output-1_R1_001.fastq.gz | seqkit grep -srp 'CAGGCTATAG.*GTGCGGCAGC' | seqkit amplicon -F CAGGCTATAG -R GCTGCCGCAC -r 11:-11 | seqkit seq -m 31 >| $OutDirectory/grep_fastq/GroupF-output-grep-1_R1_001_temp1.fastq # right\\ngunzip -cd $InDirectory/GroupF-output-1_R1_001.fastq.gz | seqkit grep -srp 'GTGCGGCAGC' | seqkit grep -m 2 -svp 'CAGGCTATAG' | sed '2~2 s/$/AAAAACCCCCTTTTTGGGGG/' | seqkit amplicon -F AGCTGTTGGG -R CCCCCAAAAAGGGGGTTTTT -r 11:-21 | seqkit seq -m 31 >| $OutDirectory/grep_fastq/GroupF-output-grep-1_R1_001_temp2.fastq\\ncat $OutDirectory/grep_fastq/GroupF-output-grep-1_R1_001_temp1.fastq $OutDirectory/grep_fastq/GroupF-output-grep-1_R1_001_temp2.fastq | bgzip >| $OutDirectory/grep_fastq/GroupF-output-grep-1_R1_001.fastq.gz" >| GroupF-output-grep-1_R1_001.sh
# echo 'grep GroupF-output-2_R1_001'
# printf "\043\041/bin/sh\\ngunzip -cd $InDirectory/GroupF-output-2_R1_001.fastq.gz | seqkit grep -srp 'CAGGCTATAG.*GTGCGGCAGC' | seqkit amplicon -F CAGGCTATAG -R GCTGCCGCAC -r 11:-11 | seqkit seq -m 31 >| $OutDirectory/grep_fastq/GroupF-output-grep-2_R1_001_temp1.fastq # right\\ngunzip -cd $InDirectory/GroupF-output-2_R1_001.fastq.gz | seqkit grep -srp 'GTGCGGCAGC' | seqkit grep -m 2 -svp 'CAGGCTATAG' | sed '2~2 s/$/AAAAACCCCCTTTTTGGGGG/' | seqkit amplicon -F AGCTGTTGGG -R CCCCCAAAAAGGGGGTTTTT -r 11:-21 | seqkit seq -m 31 >| $OutDirectory/grep_fastq/GroupF-output-grep-2_R1_001_temp2.fastq\\ncat $OutDirectory/grep_fastq/GroupF-output-grep-2_R1_001_temp1.fastq $OutDirectory/grep_fastq/GroupF-output-grep-2_R1_001_temp2.fastq | bgzip >| $OutDirectory/grep_fastq/GroupF-output-grep-2_R1_001.fastq.gz" >| GroupF-output-grep-2_R1_001.sh
# echo 'grep GroupF-output-3_R1_001'
# printf "\043\041/bin/sh\\ngunzip -cd $InDirectory/GroupF-output-3_R1_001.fastq.gz | seqkit grep -srp 'CAGGCTATAG.*GTGCGGCAGC' | seqkit amplicon -F CAGGCTATAG -R GCTGCCGCAC -r 11:-11 | seqkit seq -m 31 >| $OutDirectory/grep_fastq/GroupF-output-grep-3_R1_001_temp1.fastq # right\\ngunzip -cd $InDirectory/GroupF-output-3_R1_001.fastq.gz | seqkit grep -srp 'GTGCGGCAGC' | seqkit grep -m 2 -svp 'CAGGCTATAG' | sed '2~2 s/$/AAAAACCCCCTTTTTGGGGG/' | seqkit amplicon -F AGCTGTTGGG -R CCCCCAAAAAGGGGGTTTTT -r 11:-21 | seqkit seq -m 31 >| $OutDirectory/grep_fastq/GroupF-output-grep-3_R1_001_temp2.fastq\\ncat $OutDirectory/grep_fastq/GroupF-output-grep-3_R1_001_temp1.fastq $OutDirectory/grep_fastq/GroupF-output-grep-3_R1_001_temp2.fastq | bgzip >| $OutDirectory/grep_fastq/GroupF-output-grep-3_R1_001.fastq.gz" >| GroupF-output-grep-3_R1_001.sh

# reverse reads are uninformative
# sbatch GroupF-input-grep-1_merged_001.sh
# sbatch GroupF-input-grep-2_merged_001.sh
# sbatch GroupF-input-grep-3_merged_001.sh
sbatch GroupF-input-grep-1_R1_001.sh
sbatch GroupF-input-grep-2_R1_001.sh
sbatch GroupF-input-grep-3_R1_001.sh
sbatch GroupF-input-grep-1_R2_001.sh
sbatch GroupF-input-grep-2_R2_001.sh
sbatch GroupF-input-grep-3_R2_001.sh
sbatch GroupF-output-grep-1_R1_001.sh
sbatch GroupF-output-grep-2_R1_001.sh
sbatch GroupF-output-grep-3_R1_001.sh
