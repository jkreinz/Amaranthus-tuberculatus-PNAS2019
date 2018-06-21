#Julia Kreiner, June 2018
#Run hapcut


while read sample
do

bcftools view -s ${sample} -O z -o ${sample}.vcf.gz /ohta/julia.kreiner/waterhemp/data/finaldata_all/final_vcfs/ontario_illinois_allfiltered.vcf.gz 2> ${sample}.error &

done < /ohta/julia.kreiner/waterhemp/data/finaldata_all/final_bams/xad

#samtools sort -l 9 -o <path-for-output-file> <path-to-bam>
#samtools index -b <path-to-sorted-bam>

while read sample
do

/ohta/apps/hapcut2/hapcut2/build/extractHAIRS --VCF ${sample}.vcf --bam /ohta/julia.kreiner/waterhemp/data/finaldata_all/final_bams/${sample}.sorted.split.dedup.rg.bam > ${sample}.frag 2> ${sample}_hairs.err

done < /ohta/julia.kreiner/waterhemp/data/finaldata_all/final_bams/samples3 &

while read sample
do

/ohta/apps/hapcut2/hapcut2/build/HAPCUT2 --fragments ${sample}.frag --VCF ${sample}.vcf --output ${sample}.haplo --ea 1 > ${sample}_hapcut.log 2> ${sample}_hap.err

done < /ohta/julia.kreiner/waterhemp/data/finaldata_all/final_bams/samples1 &


#calculate block avgs and medians

ls *haplo > haps
sed -i -e 's/.haplo//g' haps 

echo sample	mean	median	min	max > allblocklengths.txt
(while read sample
do

awk -F ":" 'split($4,a," ") {print a[1]}' ${sample}.haplo | sort -rn > ${sample}_blocklength
avg=`awk -F, '{ sum += $1; n++ } END { if (n > 0) print sum / n; }' ${sample}_blocklength`
median=`sort -n ${sample}_blocklength | awk -f median.awk`
min=`sort -n ${sample}_blocklength | head -n +1`
max=`sort -nr ${sample}_blocklength | head -n +1` 
echo ${sample}	${avg}	${median}	${min}	${max}

done < haps ) >>  allblocklengths.txt &


python /ohta/apps/hapcut2/hapcut2/utilities/calculate_haplotype_statistics.py -h1 15_10.haplo -v1 15_10.vcf -f1 15_10.frag


