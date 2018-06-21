threads='6'
prefix='/ohta/julia.kreiner/waterhemp/data/illinois/alignments/sorted'
#prefix='/ohta/julia.kreiner/waterhemp/data/ontario/alignments'
ref='/ohta/julia.kreiner/waterhemp/refs/tuberculatus_ref/homo/run1/scaffolds.reduced.fa'
#ref='/ohta/julia.kreiner/waterhemp/refs/tuberculatus_ref/haplotigs.fasta'
out='/ohta/julia.kreiner/waterhemp/data/illinois/alignments/sorted'


#while read sample 
for sample in J1

do
/ohta/julia.kreiner/software/sambamba_v0.6.6 markdup -t ${threads} -p ${prefix}/${sample}.sorted.split.bam ${prefix}/${sample}.sorted.split.dedup.bam

done
#done < ill_dedup
