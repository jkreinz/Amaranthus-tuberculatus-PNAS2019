#!/bin/bash

#preprocessing based on the PAAP pipeline from vsbuffalo and rilab

datapath='/ohta/julia.kreiner/waterhemp/data/PT-645'
qualpath='/ohta/julia.kreiner/waterhemp/data/PT-645/Qual'

while read sample
do

############################
# STEP 1: STATS FROM SEQQS
############################

cat ${datapath}/${sample}.fastq | /ohta/tyler.kent/Software/seqqs/seqqs - &

############################
# STEP 2: SCYTHE TRIMMING
############################

/ohta/tyler.kent/Software/scythe/scythe -a /ohta/tyler.kent/Software/scythe/adap.fa -p 0.05 -q sanger -o ${datapath}/${sample}.trimmed.fq ${datapath}/${sample}.fastq wait

############################
# STEP 3: SEQTK TRIMMING
############################

/ohta/tyler.kent/Software/seqtk/seqtk trimfq ${datapath}/${sample}.trimmed.fq > ${datapath}/${sample}.trimmed.seqtk.fq wait

############################
# STEP 4: STATS FROM SEQQS
############################

/ohta/tyler.kent/Software/seqqs/seqqs ${datapath}/${sample}.trimmed.seqtk.fq -p ${qualpath}/Post/${sample} wait

done < ${datapath}/names_paired.txt 2> ${datapath}/pre.err > ${datapath}/pre.out
