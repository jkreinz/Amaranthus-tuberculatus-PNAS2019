
#use vcftools allele count on your VCF and then process with awk

awk '($3 == 2)' illinois_893.frq.count | awk 'split($6,a,":")  {print $2  "\t" a[2] "\t" $4 "\t" "1"}' > illinois_AFFsweepfinder.txt

