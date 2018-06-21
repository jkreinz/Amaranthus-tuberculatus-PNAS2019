while read sample
do

vcf-shuffle-cols -t regions25.vcf ${sample}.vcf > ${sample}_reorder.vcf &

done < listregions


vcf-concat regions00_reorder.vcf regions01_reorder.vcf regions02_reorder.vcf regions03_reorder.vcf regions04_reorder.vcf regions05_reorder.vcf regions06_reorder.vcf regions07_reorder.vcf regions08_reorder.vcf regions09_reorder.vcf regions10_reorder.vcf regions11_reorder.vcf regions12_reorder.vcf regions13_reorder.vcf regions14_reorder.vcf regions15_reorder.vcf regions16_reorder.vcf regions17_reorder.vcf regions18_reorder.vcf regions19_reorder.vcf regions20_reorder.vcf regions21_reorder.vcf regions22_reorder.vcf regions23_reorder.vcf regions24.vcf regions25.vcf regions26.vcf regions27.vcf regions28.vcf regions29.vcf regions30.vcf regions31.vcf regions32.vcf regions33.vcf regions34.vcf regions35.vcf regions36.vcf regions37.vcf regions38.vcf regions39.vcf regions40.vcf regions41.vcf regions42.vcf regions43.vcf regions44.vcf regions45.vcf regions46.vcf regions47.vcf regions48.vcf regions49.vcf regions50.vcf regions51.vcf regions52.vcf regions53.vcf regions54.vcf regions55.vcf regions56.vcf regions57.vcf regions58.vcf regions59.vcf regions60.vcf > ontario_all92.vcf
