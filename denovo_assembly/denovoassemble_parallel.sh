#!/bin/bash

#SCAF=$2
#START=$3
#END=$4
REGION=HTG_893:300000-550000
sample=$1
#while read sample
#do

#individual 55 has different bam filename
#if [ $1 -eq 55 ]
#then
#  BAM=${IND}_dedup.bam
#else
#  BAM=${IND}_reorder_readgroup_sorted_dedup_realign.bam
#fi

mkdir ${sample}_denovo893
cd ${sample}_denovo893

#get name of reads
samtools view /ohta/julia.kreiner/waterhemp/data/finaldata_all/final_bams/${sample}.sorted.split.dedup.rg.bam $REGION | cut -f1 > ${sample}_IDs.txt
#get unique named reads from region
awk '!x[$0]++' ${sample}_IDs.txt > ${sample}_IDs_unique.txt

#subset reads that matched
seqtk subseq /ohta/julia.kreiner/waterhemp/data/ontario/${sample}_R1.fastq.gz ${sample}_IDs_unique.txt > ${sample}_893_R1.fastq
seqtk subseq /ohta/julia.kreiner/waterhemp/data/ontario/${sample}_R2.fastq.gz ${sample}_IDs_unique.txt > ${sample}_893_R2.fastq

#denovo assemble
spades.py -o assembly -1 ${FOLDER}_893_R1.fastq -2 ${FOLDER}_893_R2.fastq > stout

cd ../

#done < walpole
