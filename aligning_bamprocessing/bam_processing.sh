#!/bin/bash

#install GATK: https://software.broadinstitute.org/gatk/guide/quickstart
#install Picard: https://broadinstitute.github.io/picard/ , https://github.com/broadinstitute/picard/releases/tag/2.8.1

#TK: set hard paths as variables so you don't need to touch the script below this section
prefix=/ohta/julia.kreiner/waterhemp/data/ontario/alignments
picard=/ohta/tyler.kent/Software/picard-2.8.1/picard.jar
gatk=/ohta/tyler.kent/Software/GATK/GenomeAnalysisTK.jar
names=/ohta/julia.kreiner/waterhemp/data/ontario/samples4.txt
ref=/ohta/julia.kreiner/waterhemp/refs/tuberculatus_ref/homo/run1/scaffolds.reduced.fa


#for ind in {1..95}
#TK: loop over names in a file...more reproducible
while read sample
do

###################
#PROCESSESING BAMS
###################
#note, from GATK: "begin by mapping the sequence reads to the reference genome to produce a file in SAM/BAM format sorted by coordinate. Next, we mark duplicates to mitigate biases introduced by data generation steps such as PCR amplification. Finally, we recalibrate the base quality scores, because the variant calling algorithms rely heavily on the quality scores assigned to the individual base calls in each sequence read."


#Sort and index

ohta/julia.kreiner/software/sambamba_v0.6.6 sort -t 8 -p -o ${prefix}/${sample}.sorted.bam ${prefix}/${sample}.bam >> ~/sort1.out 2>> ~/sort2.out 

#gzip ${prefix}/${sample}.bam

java -Djava.io.tmpdir=~/tmp -jar $picard AddOrReplaceReadGroups \
	INPUT=${prefix}/${sample}.sorted.bam \
	OUTPUT=${prefix}/${sample}.sorted.rg.bam \
	RGLB=AmaranthOnt \
	RGPL=Illumina \
	RGPU=unit1 \
	RGSM=${sample} \
	>> ~/RG.out 2>> ~/RG.err
	
java -Djava.io.tmpdir=~/tmp -jar $picard BuildBamIndex \
      I=${prefix}/${sample}.sorted.rg.bam

#Splits Cigars
java -Djava.io.tmpdir=~/tmp -jar $gatk -T SplitNCigarReads -R ${ref} -I ${prefix}/${sample}.sorted.rg.bam -o ${prefix}/${sample}.sorted.split.bam -rf ReassignOneMappingQuality -RMQF 255 -RMQT 60 -U ALLOW_N_CIGAR_READS >${sample}.sorted.split.out 2>${sample}.sorted.split.err

#Mark Duplicates & Index - this is the generalized command
java -Djava.io.tmpdir=~/tmp -jar $picard MarkDuplicates \ 
    INPUT=${prefix}/${sample}.sorted.split.bam \ 
    OUTPUT=${prefix}/${sample}.sorted.split.dedup.bam \
    METRICS_FILE=${prefix}/${sample}.metrics.txt


#creates a GATKReport file, Analyze patterns of covariation in the sequence dataset
#java -jar $gatk \ 
#    -T BaseRecalibrator \ 
#    -R ${ref} \ 
#    -I ${prefix}/${sample}.sorted.dedup.bam \ 
#    -L 20 \ 
#    -knownSites gold_indels.vcf \ 
#    -o recal_data.table 
#analyze covariation remaining after recalibration
#java -jar $gatk \ 
#    -T BaseRecalibrator \ 
#    -R reference.fa \ 
#    -I realigned_reads.bam \ 
#    -L 20 \ 
#    -knownSites dbsnp.vcf \ 
##    -knownSites gold_indels.vcf \ 
#    -BQSR recal_data.table \ 
#    -o post_recal_data.table 
# Generate before/after plots
#java -jar $gatk \ 
#    -T AnalyzeCovariates \ 
#    -R reference.fa \ 
#    -L 20 \ 
#    -before recal_data.table \
#    -after post_recal_data.table \
#    -plots recalibration_plots.pdf
#Apply the recalibration to your sequence data
#java -jar $gatk \ 
#    -T PrintReads \ 
#    -R reference.fa \ 
#    -I realigned_reads.bam \ 
#    -L 20 \ 
#    -BQSR recal_data.table \ 
#    -o recal_reads.bam 


###################
#VARIANT DISCOVERY
###################

#Run haplotype caller with GVCF function
#java -Djava.io.tmpdir=~/tmp -jar $gatk -T HaplotypeCaller -R ${ref} -I ${prefix}/${sample}.sorted.split.dedup.bam -dontUseSoftClippedBases -stand_call_conf 20.0 -stand_emit_conf 20.0 -o ${prefix}/${sample}.g.vcf -ERC GVCF >${prefix}/${sample}_hapl.out 2>${prefix}/${sample}_hapl.err

done < $names

#up until now running commands over a loop for each file, the next step joins all files into one.

#CombineGVCFs
#ljava -Djava.io.tmpdir=~/tmp -jar $gatk  -T CombineGVCFs -R ${ref} --variant xx --variant xx --variant xx -o eurcancomb.g.vcf  > combgvcf.out 2> combgvcf.err


###########
#FILTERING VARIANTS (stephen intially told me to do hard filterting but i think i'd like to try what GATK recommends - see https://software.broadinstitute.org/gatk/documentation/article?id=2805) 
###########
#see below for hard filtering
#filter by GQ
#java -jar $gatk -R /cap1/julia.kreiner/rubella_genome/Capsella_rubella_v1.0_combined.fasta -T VariantFiltration --variant can_justeur.vcf -o eurcan_GQfilt.vcf.gz --genotypeFilterExpression 'GQ<30.0' --genotypeFilterName 'lowGQ'  2> filtGQ.er

#remove filtered vars (value for maxFilteredGenotypes is the 20% cuttoff - i.e. don't print sites where more than 20% of individuals have low qual)
#java -jar $gatk -T SelectVariants -R /cap1/julia.kreiner/rubella_genome/Capsella_rubella_v1.0_combined.fasta -V eurcan_GQfilt.vcf.gz --maxFilteredGenotypes 74 --maxFractionFilteredGenotypes .2  -o eurcan_excludedGQ2.vcf

#filter missing
#vcftools --vcf eurcan_excludedGQ2.vcf --recode --recode-INFO-all --max-missing 0.8 --out eurcan_filtGQ_missing
