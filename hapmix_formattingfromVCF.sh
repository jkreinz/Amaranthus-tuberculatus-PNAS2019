#Julia Kreiner, June 2018
#Format VCF files for running hapmix (requires 3 populations: 2 putative parental populations that are phased and contain the same SNP set, and a focal putitively introgressed population that is unphased and a contains a subset of SNP's from the parentals)

awk '{print $1 "\t" $2}' 893_phased_natessex.recode.vcf | grep -v '#'> matchsnps
vcftools --vcf allsamples_893_missing.recode.vcf --keep illinois --out 893_illinois_unphased --min-alleles 2 --max-alleles 2 --recode --positions matchsnps

#vcftools --vcf allsamples_893_missing.recode.vcf --keep illinois --out 893_illinois_unphased --min-alleles 2 --max-alleles 2 --recode
#awk '{print $1 "\t" $2}' 893_illinois_unphased.recode.vcf | grep -v '#'> ill_matchsnps
#vcftools --vcf allsamples_893_missing.recode.vcf --keep nat --out 893_illinois_unphased --min-alleles 2 --max-alleles 2 --recode


vcftools --gzvcf 893_phased.vcf.gz --keep essex --out 893_phased_essex --phased --min-alleles 2 --max-alleles 2
vcftools --gzvcf 893_phased.vcf.gz --keep nat --out 893_phased_nat --phased --min-alleles 2 --max-alleles 2
#drop triallelic sites
awk '$5 !~ ","' 893_phased_essex.recode.vcf > 893_phased_essex_bi.recode.vcf
awk '$5 !~ ","' 893_phased_nat.recode.vcf > 893_phased_nat_bi.recode.vcf
awk -f formatsnpfile.awk 893_phased_essex_bi.recode.vcf > essex01
awk -f formatsnpfile.awk 893_phased_nat_bi.recode.vcf > nat01
awk -f formatsnpfile2.awk essex01 > essex01_2
awk -f formatsnpfile2.awk nat01 > nat01_2

paste <(printf "HTG_893\n%.0s" {1..26873}) nat01_2 > nat01_3
paste <(printf "HTG_893\n%.0s" {1..45296}) essex01_2 > essex01_3
awk 'NR==FNR{c[$1$2]++;next};c[$1$2] > 0' nat01_3 essex01_3 > essex01_4
awk 'NR==FNR{c[$1$2]++;next};c[$1$2] > 0' essex01_4 nat01_3 > nat01_4
awk 'NR==FNR{c[$1$2]++;next};c[$1$2] > 0' nat01_4 893_illinois_unphased.recode.vcf > illinois_012_matched.vcf

grep '#' 893_illinois_unphased.recode.vcf > illinois_header
cat illinois_header illinois_012_matched.vcf > illinois_012_matched_wh.vcf
vcftools --max-missing .8 --vcf illinois_012_matched_wh.vcf --remove-indels --recode --out illinois_012_matched_wh_missing
vcftools --max-missing .8 --012 --vcf illinois_012_matched_wh.vcf --remove-indels --out illinois_012_matched_wh_missing --positions ill_snps

awk 'NR==FNR{c[$1$2]++;next};c[$1$2] > 0' nat01_4 illinois_012_matched_wh_missing.recode.vcf > illinois_012_matched2.vcf
cat illinois_header illinois_012_matched2.vcf > illinois_012_matched_wh.vcf
grep -v "#" illinois_012_matched_wh.vcf | awk '{print $1"\t"$2"\t"$4"\t"$5}' > illinois012_5

awk '{print $1 "\t" $2}' nat01_4 > ref_pos
vcftools --gzvcf 893_phased.vcf.gz --keep nat --out 893_phased_nat2 --phased --positions ref_pos --recode
vcftools --gzvcf 893_phased.vcf.gz --keep essex --out 893_phased_essex2 --phased --positions ref_pos --recode
grep -v "#" 893_phased_essex2.recode.vcf | awk '{print $1"\t"$2"\t"$4"\t"$5}' > essex01_5 
grep -v "#" 893_phased_nat2.recode.vcf | awk '{print $1"\t"$2"\t"$4"\t"$5}' > nat01_5
#files to impute genetic positions: essex01_5, nat01_5, illinois012_5


#get geno file
sed -e '15370d' nat01_4 | cut -f3- --output-delimiter="" > nat_geno.22
cat nat_geno.22 | tr -d '\000'  > nat_genotype.22

sed -e '15370d' essex01_4 | cut -f3-  --output-delimiter="" > essex_geno.22
cat essex_geno.22 | tr -d '\000'  > essex_genotype.22

awk '{print $2 "\t" $4}' illinois_snpformat.22 > ill_snps
vcftools --max-missing .8 --012 --vcf illinois_012_matched_wh.vcf --remove-indels --out illinois_012_matched_wh_missing --positions ill_snps
awk -f ../../transpose.awk ../../illinois_012_matched_wh_missing.012 > illinois012_trans.txt
tail -n +2 illinois012_trans.txt | sed 's/-1/9/g' | tr -d ' ' > illinois_genotype.22


#get recomb file
bash recombfile.sh

#get ind file
cp illinois_012_matched_wh_missing.012.indv illinois_ind
awk '{print $1 "\t" $1 "\t" "WAL"}' illinois_ind > illinois.ind


#doublecheck

awk 'NR==FNR{c[$2$4]++;next};c[$2$4] > 0' essex_snpformat.22 illinois_snpformat.22 > illinois_snpformat_matched.22
