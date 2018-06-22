for sample in regions30.vcf  regions31.vcf  regions32.vcf  regions33.vcf  regions34.vcf  regions35.vcf  regions36.vcf  regions37.vcf  regions38.vcf  regions39.vcf  regions40.vcf  regions41.vcf  regions42.vcf  regions43.vcf  regions44.vcf  regions45.vcf  regions46.vcf  regions47.vcf  regions48.vcf  regions49.vcf  regions50.vcf  regions51.vcf  regions52.vcf  regions53.vcf  regions54.vcf  regions55.vcf  regions56.vcf  regions57.vcf  regions58.vcf  regions59.vcf  regions60.vcf

do

bgzip -c ${sample} > ${sample}.gz &
tabix -f -p vcf ${sample}.gz &

done
