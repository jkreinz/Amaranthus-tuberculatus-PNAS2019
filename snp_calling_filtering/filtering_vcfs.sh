#Julia Kreiner, June 2018
#STEPS FOR FILTERING WHOLE GENOME SEQUENCE DATA, SNPCALLED BY FREEBAYES (modified from http://ddocent.com/filtering/ for more details)

######################################################################
#filter sites where more than 80% of indiviudals have missing data
######################################################################

vcftools --vcf ontario_all92.vcf --recode --recode-INFO-all --max-missing 0.8 --out ontario_all92_missing

######################################################################
#estimate missing data for each individual
######################################################################

vcftools --vcf ontario_all92_missing.recode.vcf --missing-indv

######################################################################
#use cutoff from missing data distribution to drop individuals with more than 25% missing data
######################################################################

~/software/bin/bin/mawk '$5 > 0.25' out.imiss | cut -f1 > lowDP.indv
vcftools --vcf ontario_all92_missing.recode.vcf --remove lowDP.indv --recode --recode-INFO-all --out ontario_all92_missing_indmiss


######################################################################
#mask low complexity regions
######################################################################

dustmasker -in scaffolds.reduced.fa -out scaffolds.reduced.dustmasked.list -outfmt acclist
awk 'split($1,a,">") {print a[2]"\t"$2-1"\t"$3}' scaffolds.reduced.dustmasked.list > dustmasked.bed #also need to remove -1 values
bedtools subtract -a ontario_all92_missing_indmiss.recode.vcf -b dustmasked.bed > ontario_all92_missing_indmiss_dustmasked.vcf
grep "#" ontario_all92_missing_indmiss.recode.vcf > header
cat headers ontario_all92_missing_indmiss_dustmasked.vcf > ontario_all92_missing_indmiss_dustmasked_rehdrs.vcf

###################################################################### 
#filter by QUAL/DEPTH (error prone and high copy number loci)
######################################################################

vcffilter -f "QUAL / DP > 0.25" ontario_all92_missing_indmiss_dustmasked_rehdrs.vcf > ontario_all92_missing_qualOdp.vcf
cut -f8 ontario_all92_missing_qualOdp.vcf | grep -oe "DP=[0-9]*" | sed -s 's/DP=//g' > ontario_all92_missing_qualOdp.DEPTH
grep -v "#" ontario_all92_missing_qualOdp.vcf | cut -f1,2,6 > ontario_all92_missing_qualOdp.vcf.loci.qual
~/software/bin/bin/mawk '{ sum += $1; n++ } END { if (n > 0) print sum / n; }' ontario_all92_missing_qualOdp.DEPTH

python -c "print int(1490.58+(4*(1490.58**0.5)))"  = 1645

paste ontario_all92_missing_qualOdp.vcf.loci.qual ontario_all92_missing_qualOdp.DEPTH | ~/software/bin/bin/mawk -v x=1645 '$4 > x' | ~/software/bin/bin/mawk '$3 < 2 * $4' > ontario_all92_missing.lowQDloci
vcftools --vcf ontario_all92_missing_qualOdp.vcf --site-depth --exclude-positions ontario_all92_missing.lowQDloci --out ontario_all92_missing_indmiss_filtqualbydepth

cut -f3 ontario_all92_missing_indmiss_filtqualbydepth.ldepth > ontario_all92_missing_indmiss_filtqualbydepth.justdepth

~/software/bin/bin/mawk '!/D/' ontario_all92_missing_indmiss_filtqualbydepth.justdepth  | ~/software/bin/bin/mawk -v x=73 '{print $1/x}' > meandepthpersite

vcftools --vcf ontario_all92_missing_qualOdp.vcf --recode-INFO-all --out llinois_multi_missing_indmiss_filtqualbydepth --max-meanDP 25 --exclude-positions ontario_all92_missing.lowQDloci --recode 


######################################################################
#filter on allelic balance for heterozygous calls
######################################################################

vcffilter -s -f "AB > 0.25 & AB < 0.75 | AB < 0.01" ontario_all92_missing_indmiss_dustmasked_filtqualbydepth.vcf > ontario_all92_missing_indmiss_dustmasked_filtqualbydepth_AB.vcf &

######################################################################
#filter sites that have over 100 times more forward alternate reads than reverse alternate reads and 100 times more forward reference reads than reverse reference reads along with the reciprocal.
######################################################################

#not using this filter since it drops way too many sites - why are most sites covered by both forward and reverse reads???

#vcffilter -f "SAF / SAR > 100 & SRF / SRR > 100 | SAR / SAF > 100 & SRR / SRF > 100" -s ontario_all92_missing_indmiss_dustmasked_filtqualbydepth_AB.vcf > ontario_all92_missing_indmiss_dustmasked_filtqualbydepth_AB_RB.vcf

######################################################################
#filter on whether or not their is a discrepancy in the properly paired status of for reads supporting reference or alternate alleles
######################################################################

vcffilter -f "PAIRED > 0.05 & PAIREDR > 0.05 & PAIREDR / PAIRED < 1.75 & PAIREDR / PAIRED > 0.25 | PAIRED < 0.05 & PAIREDR < 0.05" -s ontario_all92_missing_indmiss_dustmasked_filtqualbydepth_AB.vcf > ontario_all92_missing_indmiss_dustmasked_filtqualbydepth_AB_PS.vcf

######################################################################
#since freebayes, drop sites where QUAL < 30 (1/1000 error rate)
######################################################################

vcffilter -f "QUAL > 30" ontario_all92_missing_indmiss_dustmasked_filtqualbydepth_AB_PS.vcf > ontario_all92_missing_indmiss_dustmasked_filtqualbydepth_AB_PS_QUAL.vcf

######################################################################
#HW filter
######################################################################

#not doing this since removes too many sites and requires pop level analyses
#vcfallelicprimitives ontario_all92_missing_indmiss_dustmasked_filtqualbydepth_AB_PS_QUAL.vcf --keep-info --keep-geno > ontario_all92_missing_indmiss_dustmasked_filtqualbydepth_AB_PS_QUAL_prim.vcf

vcftools --vcf ontario_all92_missing_indmiss_dustmasked_filtqualbydepth_AB_PS_QUAL.vcf --remove-indels --recode --recode-INFO-all --out ontario_all92_missing_indmiss_dustmasked_filtqualbydepth_AB_PS_QUAL_noindels

#./filter_hwe_by_pop.pl -v ontario_all92_missing_indmiss_dustmasked_filtqualbydepth_AB_PS_QUAL_noindels.recode.vcf -p popmap -o ontario_all92_missing_indmiss_dustmasked_filtqualbydepth_AB_PS_QUAL_HW_HWE

