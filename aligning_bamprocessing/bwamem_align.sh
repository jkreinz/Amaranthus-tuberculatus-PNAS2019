#Julia Kreiner, June 2018
#!/bin/bash

#Align paired, trimmed, reads with bwa mem

threads='5'
#data='/ohta/julia.kreiner/waterhemp/data/illinois/PT-645'
data='/ohta/julia.kreiner/waterhemp/data/ontario'
#ref='/ohta/julia.kreiner/waterhemp/refs/tuberculatus_ref/homo/run1/scaffolds.reduced.fa'
ref='/ohta/julia.kreiner/waterhemp/refs/tuberculatus_scaffolds.fasta'
#out='/ohta/julia.kreiner/waterhemp/data/ontario/alignments'
#out='/ohta/julia.kreiner/waterhemp/data//alignments'
out='/ohta/julia.kreiner/waterhemp/data/realigned'

#index fasta
#/ohta/tyler.kent/Software/bwa-0.7.12/bwa index ${ref}/amaranth_hypo_pacbioref.fasta	


#align
while read sample

#for sample in J1
do

#/ohta/tyler.kent/Software/bwa-0.7.12/bwa mem -t ${threads} -M ${ref} ${data}/${sample}_R1.fastq.gz ${data}/${sample}_R2.fastq.gz |\
#        samtools view -bh - > ${out}/${sample}.bam 2> ${out}/${sample}.err

/ohta/tyler.kent/Software/bwa-0.7.12/bwa mem -t ${threads} -M ${ref} ${data}/${sample}_R1.fastq.gz ${data}/${sample}_R2.fastq.gz |\
        samtools view -bh - > ${out}/${sample}.bam 2> ${out}/${sample}.err &

done < ${data}/names01

#try with stampy:

#ohta/tyler.kent/Software/bwa-0.7.12/bwa aln -q10 -t8 hg18 ${data}/BY-121/${sample}.R1.fastq > 1.sai
#    bwa aln -q10 -t8 hg18 ${data}/BY-121/${sample}.R2.fastq > 2.sai
#    bwa sampe hg18 1.sai 2.sai reads_1.fastq reads_2.fastq | \
#        samtools view -Sb - > bwa.bam

#    ./stampy.py -g hg18 -h hg18 -t8 --bamkeepgoodreads -M bwa.bam

#or maybe lets try with NextGenMap

#ngm -r ${ref}/amaranth_hypo_pacbioref.fasta -1 ${data}/BY-121/${sample}.R1.trimmed.seqtk.fq -2 ${data}/BY-121/${sample}.R2.trimmed.seqtk.fq -t 5 -g 0,1 --very-sensitive |\

#        samtools view -bh - > /ohta/julia.kreiner/waterhemp/data/BY-121/${sample}.bam 2> /ohta/julia.kreiner/waterhemp/data/BY-121/${sample}.err


#done < ${data}/names.txt
