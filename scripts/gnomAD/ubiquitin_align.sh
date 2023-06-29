#!/bin/bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=20G
#SBATCH --job-name=ubiquitin_align



cat data/gnomADv2.1.1/insert_fastas/* > data/gnomADv2.1.1/insert_fastas/all.fa
needleall -auto -asequence data/ub_subunit_consensus.fa -bsequence data/gnomADv2.1.1/insert_fastas/all.fa -minscore 100 -aformat_outfile srspair -outfile data/gnomADv2.1.1/ubiquitin_alignment.txt -errfile data/gnomADv2.1.1/needleall.error

cat data/gnomADv3.1.1/insert_fastas/* > data/gnomADv3.1.1/insert_fastas/all.fa
needleall -auto -asequence data/ub_subunit_consensus.fa -bsequence data/gnomADv3.1.1/insert_fastas/all.fa -minscore 100 -aformat_outfile srspair -outfile datadata/gnomADv3.1.1/ubiquitin_alignment.txt -errfile data/gnomADv3.1.1/needleall.error