prefix=/ohta/julia.kreiner/waterhemp/data/ontario/alignments/sorted
picard=/ohta/tyler.kent/Software/picard-2.8.1/picard.jar

while read sample
do

java -Djava.io.tmpdir=~/tmp -jar $picard AddOrReplaceReadGroups \
        INPUT=${prefix}/${sample}.sorted.split.dedup.bam \
        OUTPUT=${prefix}/${sample}.sorted.split.dedup.rg.bam \
        RGID=${sample} \
	RGLB=${sample} \
        RGPL=${sample} \
        RGPU=${sample} \
        RGSM=${sample} \
        >> ${sample}.out 2>> ${sample}.err &

done < list00

wait

while read sample
do

java -Djava.io.tmpdir=~/tmp -jar $picard AddOrReplaceReadGroups \
        INPUT=${prefix}/${sample}.sorted.split.dedup.bam \
        OUTPUT=${prefix}/${sample}.sorted.split.dedup.rg.bam \
        RGID=${sample} \
        RGLB=${sample} \
        RGPL=${sample} \
        RGPU=${sample} \
        RGSM=${sample} \
        >> ${sample}.out 2>> ${sample}.err &

done < list01

while read sample
do

java -Djava.io.tmpdir=~/tmp -jar $picard AddOrReplaceReadGroups \
        INPUT=${prefix}/${sample}.sorted.split.dedup.bam \
        OUTPUT=${prefix}/${sample}.sorted.split.dedup.rg.bam \
        RGID=${sample} \
        RGLB=${sample} \
        RGPL=${sample} \
        RGPU=${sample} \
        RGSM=${sample} \
        >> ${sample}.out 2>> ${sample}.err &

done < list02

wait

while read sample
do

java -Djava.io.tmpdir=~/tmp -jar $picard AddOrReplaceReadGroups \
        INPUT=${prefix}/${sample}.sorted.split.dedup.bam \
        OUTPUT=${prefix}/${sample}.sorted.split.dedup.rg.bam \
        RGID=${sample} \
        RGLB=${sample} \
        RGPL=${sample} \
        RGPU=${sample} \
        RGSM=${sample} \
        >> ${sample}.out 2>> ${sample}.err &

done < list03

wait

while read sample
do

java -Djava.io.tmpdir=~/tmp -jar $picard AddOrReplaceReadGroups \
        INPUT=${prefix}/${sample}.sorted.split.dedup.bam \
        OUTPUT=${prefix}/${sample}.sorted.split.dedup.rg.bam \
        RGID=${sample} \
        RGLB=${sample} \
        RGPL=${sample} \
        RGPU=${sample} \
        RGSM=${sample} \
        >> ${sample}.out 2>> ${sample}.err &

done < list04
