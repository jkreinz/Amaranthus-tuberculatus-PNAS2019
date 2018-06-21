####Julia Kreiner, June 2018
##Run selscan 


#find SNPs with two entries
uniq -d sites.txt > drop

#drop SNPs with two entries
vcftools --vcf 893_phased_walpoleref_bi.recode.vcf --exclude-positions drop --recode --recode-INFO-all --out 893_phased_walpoleref_bi_filt
vcftools --vcf 893_phased_walpolesel_bi.recode.vcf --exclude-positions drop --recode --recode-INFO-all --out 893_phased_walpolesel_bi_filt

#get sites to do imputation on in R, based on *unique* phased snsp
grep -v '#' 893_phased_walpolesel_bi_filt.recode.vcf | awk '{print $1 "\t" $2}' > sites.txt

#drop sites that were excluded from imputation for being unordered

vcftools --vcf 893_phased_walpolesel_bi_filt.recode.vcf --exclude-positions drop --recode --recode-INFO-all --out 893_phased_walpolesel_bi_filt2

vcftools --vcf 893_phased_walpoleref_bi_filt.recode.vcf --exclude-positions drop --recode --recode-INFO-all --out 893_phased_walpoleref_bi_filt2

#run selscan: XPEHH score
selscan --xpehh --vcf-ref 893_phased_walpoleref_bi_filt2.recode.vcf --vcf 893_phased_walpolesel_bi_filt2.recode.vcf --map phased_snps.map --out XPEHH_walpole --threads 5

#run selscan: IHH12 (better power to detect soft sweeps that H12 stat)
selscan --ihh12 --vcf 893_phased_walpoleref_bi_filt2.recode.vcf --map phased_snps.map --out iHH12_walpole_ref --threads 5

selscan --ihh12 --vcf 893_phased_walpolesel_bi_filt2.recode.vcf --map phased_snps.map --out iHH12_walpole_sel --threads 5

#run selscan: iHS
selscan --ihs --vcf 893_phased_walpolesel_bi_filt2.recode.vcf --map phased_snps.map --out iHS_walpole_sel --threads 5

selscan --ihs --vcf 893_phased_walpoleref_bi_filt2.recode.vcf --map phased_snps.map --out iHS_walpole_ref --threads 5

########
#do for essex
#######
vcftools --vcf 893_phased_essex_bi.recode.vcf --positions match --recode --recode-INFO-all --out 893_phased_essex_bi_filt

vcftools --keep ../essex_resistant --vcf 893_phased_essex_bi_filt.recode.vcf --recode --recode-INFO-all --out 893_phased_essex_bi_filt_resistant

vcftools --keep ../essex_susceptible --vcf 893_phased_essex_bi_filt.recode.vcf --recode --recode-INFO-all --out 893_phased_essex_bi_filt_susceptible

#run selscan: XPEHH score
selscan --xpehh --vcf-ref 893_phased_essex_bi_filt_susceptible.recode.vcf --vcf 893_phased_essex_bi_filt_resistant.recode.vcf --map phased_snps.map --out XPEHH_essex --threads 5

#run selscan: IHH12 (better power to detect soft sweeps that H12 stat)
selscan --ihh12 --vcf 893_phased_essex_bi_filt_susceptible.recode.vcf --map phased_snps.map --out iHH12_essex_ref --threads 5

selscan --ihh12 --vcf 893_phased_essex_bi_filt_resistant.recode.vcf --map phased_snps.map --out iHH12_essex_sel --threads 5

#run selscan: iHS
selscan --ihs --vcf 893_phased_essex_bi_filt_susceptible.recode.vcf --map phased_snps.map --out iHS_essex_ref --threads 5

selscan --ihs --vcf 893_phased_essex_bi_filt_resistant.recode.vcf --map phased_snps.map --out iHS_essex_sel --threads 5

########
#do for illinois
#######
vcftools --gzvcf ../893_phased.vcf.gz --positions match --recode --recode-INFO-all --out 893_phased_illinois_bi_filt --max-alleles 2 --min-alleles 2 --keep ../illinois

vcftools --keep illinois_resistant --vcf 893_phased_illinois_bi_filt.recode.vcf --recode --recode-INFO-all --out 893_phased_illinois_bi_filt_resistant

vcftools --keep illinois_susceptible --vcf 893_phased_illinois_bi_filt.recode.vcf --recode --recode-INFO-all --out 893_phased_illinois_bi_filt_susceptible

#run selscan: XPEHH score
selscan --xpehh --vcf-ref 893_phased_illinois_bi_filt_susceptible.recode.vcf --vcf 893_phased_illinois_bi_filt_resistant.recode.vcf --map phased_snps.map --out XPEHH_illinois --threads 5

#run selscan: IHH12 (better power to detect soft sweeps that H12 stat)
selscan --ihh12 --vcf 893_phased_illinois_bi_filt_susceptible.recode.vcf --map phased_snps.map --out iHH12_illinois_ref --threads 5

selscan --ihh12 --vcf 893_phased_illinois_bi_filt_resistant.recode.vcf --map phased_snps.map --out iHH12_illinois_sel --threads 5

#run selscan: iHS
selscan --ihs --vcf 893_phased_illinois_bi_filt_susceptible.recode.vcf --map phased_snps.map --out iHS_illinois_ref --threads 5

selscan --ihs --vcf 893_phased_illinois_bi_filt_resistant.recode.vcf --map phased_snps.map --out iHS_illinois_sel --threads 5

