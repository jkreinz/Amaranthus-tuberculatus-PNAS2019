#walpole
##resistant
vcftools --vcf ontario_893_miss_indel.recode.vcf --counts --out walpole_resistant_893 --keep walpole_selected.txt
awk '($3 == 2)' walpole_resistant_893.frq.count | awk 'split($6,a,":")  {print $2  "\t" a[2] "\t" $4 "\t" "1"}' > walpole_resistant_AFFsweepfinder.txt
cat /ohta/julia.kreiner/waterhemp/data/finaldata_all/final_bams/pileups/walpole_resistant_AFFsweepfinder.txt | sed '4504d;4750d;12848d;60813d;60814d;60815d' > walpole_resistant_AFFsweepfinder_sitesremoved.txt
sed -i '60809d' walpole_resistant_AFFsweepfinder_sitesremoved.txt
sed -i '1iposition\tx\tn\tfolded' walpole_resistant_AFFsweepfinder_sitesremoved.txt
./SweepFinder2 -f walpole_resistant_AFFsweepfinder_sitesremoved.txt SpectFile
./SweepFinder2 -lr 1000 walpole_resistant_AFFsweepfinder_sitesremoved.txt SpectFile walpole_sweep.recomb Walpole_resistant_recombcontrolled.sweep


#walpole
##susceptible
vcftools --vcf ontario_893_miss_indel.recode.vcf --counts --out walpole_reference_893 --keep walpole_reference.txt
awk '($3 == 2)' walpole_reference_893.frq.count | awk 'split($6,a,":")  {print $2  "\t" a[2] "\t" $4 "\t" "1"}' > walpole_susceptible_AFFsweepfinder.txt
cat /ohta/julia.kreiner/waterhemp/data/finaldata_all/final_bams/pileups/walpole_susceptible_AFFsweepfinder.txt | sed '4504d;4750d;12848d;60813d;60814d;60815d' > walpole_susceptible_AFFsweepfinder_sitesremoved.txt
sed -i '60809d' walpole_susceptible_AFFsweepfinder_sitesremoved.txt
sed -i '1iposition\tx\tn\tfolded' walpole_susceptible_AFFsweepfinder_sitesremoved.txt
./SweepFinder2 -f walpole_susceptible_AFFsweepfinder_sitesremoved.txt SpectFile
./SweepFinder2 -lr 1000 walpole_susceptible_AFFsweepfinder_sitesremoved.txt SpectFile walpole_sweep.recomb Walpole_susceptible_recombcontrolled.sweep

##################

#essex
##resistant
vcftools --vcf ontario_893_miss_indel.recode.vcf --counts --out essex_resistant_893 --keep essex_resistant
awk '($3 == 2)' essex_resistant_893.frq.count | awk 'split($6,a,":")  {print $2  "\t" a[2] "\t" $4 "\t" "1"}' > essex_resistant_AFFsweepfinder.txt
cat /ohta/julia.kreiner/waterhemp/data/finaldata_all/final_bams/pileups/essex_resistant_AFFsweepfinder.txt | sed '4504d;4750d;12848d;60813d;60814d;60815d' > essex_resistant_AFFsweepfinder_sitesremoved.txt
sed -i '60809d' essex_resistant_AFFsweepfinder_sitesremoved.txt
sed -i '1iposition\tx\tn\tfolded' essex_resistant_AFFsweepfinder_sitesremoved.txt
./SweepFinder2 -f essex_resistant_AFFsweepfinder_sitesremoved.txt SpectFile
./SweepFinder2 -lr 1000 essex_resistant_AFFsweepfinder_sitesremoved.txt SpectFile essex_sweep.recomb Essex_resistant_recombcontrolled.sweep


#essex
##susceptible
vcftools --vcf ontario_893_miss_indel.recode.vcf --counts --out essex_reference_893 --keep essex_susceptible
awk '($3 == 2)' essex_reference_893.frq.count | awk 'split($6,a,":")  {print $2  "\t" a[2] "\t" $4 "\t" "1"}' > essex_susceptible_AFFsweepfinder.txt
cat /ohta/julia.kreiner/waterhemp/data/finaldata_all/final_bams/pileups/essex_susceptible_AFFsweepfinder.txt | sed '4504d;4750d;12848d;60813d;60814d;60815d' > essex_susceptible_AFFsweepfinder_sitesremoved.txt
sed -i '60809d' essex_susceptible_AFFsweepfinder_sitesremoved.txt
sed -i '1iposition\tx\tn\tfolded' essex_susceptible_AFFsweepfinder_sitesremoved.txt
./SweepFinder2 -f essex_susceptible_AFFsweepfinder_sitesremoved.txt SpectFile
./SweepFinder2 -lr 1000 essex_susceptible_AFFsweepfinder_sitesremoved.txt SpectFile essex_sweep.recomb Essex_susceptible_recombcontrolled.sweep
 
#####################

#illinois
vcftools --vcf illinois_893_miss_indel.recode.vcf --counts --out illinois_resistant_893 --keep illinois_selected.txt
awk '($3 == 2)' illinois_resistant_893.frq.count | awk 'split($6,a,":")  {print $2  "\t" a[2] "\t" $4 "\t" "1"}' > illinois_resistant_AFFsweepfinder.txt
cat /ohta/julia.kreiner/waterhemp/data/finaldata_all/final_bams/pileups/illinois_resistant_AFFsweepfinder.txt | sed '2995d;10291d;57197d;57198d;57286d;57287d' > illinois_resistant_AFFsweepfinder_sitesremoved.txt
sed -i '1iposition\tx\tn\tfolded' illinois_resistant_AFFsweepfinder_sitesremoved.txt
./SweepFinder2 -f illinois_resistant_AFFsweepfinder_sitesremoved.txt SpectFile_Illinois
./SweepFinder2 -lr 1000 illinois_resistant_AFFsweepfinder_sitesremoved.txt SpectFile_Illinois illinois_sweep.recomb Illinois_resistant_recombcontrolled.sweep

#illinois SUS
vcftools --vcf illinois_893_miss_indel.recode.vcf --counts --out illinois_susceptible_893 --keep illinois_reference.txt
awk '($3 == 2)' illinois_susceptible_893.frq.count | awk 'split($6,a,":")  {print $2  "\t" a[2] "\t" $4 "\t" "1"}' > illinois_susceptible_AFFsweepfinder.txt
cat /ohta/julia.kreiner/waterhemp/data/finaldata_all/final_bams/pileups/illinois_susceptible_AFFsweepfinder.txt | sed '2995d;10291d;57197d;57198d;57286d;57287d' > illinois_susceptible_AFFsweepfinder_sitesremoved.txt
sed -i '1iposition\tx\tn\tfolded' illinois_susceptible_AFFsweepfinder_sitesremoved.txt
./SweepFinder2 -f illinois_susceptible_AFFsweepfinder_sitesremoved.txt SpectFile_Illinois
./SweepFinder2 -lr 1000 illinois_susceptible_AFFsweepfinder_sitesremoved.txt SpectFile_Illinois illinois_sweep.recomb Illinois_susceptible_recombcontrolled.sweep

#illinios K

#illinois
vcftools --vcf illinois_893_miss_indel.recode.vcf --counts --out popK --keep pop_K
awk '($3 == 2)' popK.frq.count | awk 'split($6,a,":")  {print $2  "\t" a[2] "\t" $4 "\t" "1"}' > popk_AFFsweepfinder.txt
cat /ohta/julia.kreiner/waterhemp/data/finaldata_all/final_bams/pileups/popk_AFFsweepfinder.txt | sed '2995d;10291d;57197d;57198d;57286d;57287d' > popk_AFFsweepfinder_sitesremoved.txt
sed -i '1iposition\tx\tn\tfolded' popk_AFFsweepfinder_sitesremoved.txt
./SweepFinder2 -f popk_AFFsweepfinder_sitesremoved.txt SpectFile_popk
./SweepFinder2 -lr 1000 popk_AFFsweepfinder_sitesremoved.txt SpectFile_popk illinois_sweep.recomb popk_recombcontrolled.sweep

vcftools --vcf illinois_893_miss_indel.recode.vcf --counts --out popG --keep popG
awk '($3 == 2)' popG.frq.count | awk 'split($6,a,":")  {print $2  "\t" a[2] "\t" $4 "\t" "1"}' > popG_AFFsweepfinder.txt
cat /ohta/julia.kreiner/waterhemp/data/finaldata_all/final_bams/pileups/popG_AFFsweepfinder.txt | sed '2995d;10291d;57197d;57198d;57286d;57287d' > popG_AFFsweepfinder_sitesremoved.txt
sed -i '1iposition\tx\tn\tfolded' popG_AFFsweepfinder_sitesremoved.txt
./SweepFinder2 -f popG_AFFsweepfinder_sitesremoved.txt SpectFile_popG
./SweepFinder2 -lr 1000 popG_AFFsweepfinder_sitesremoved.txt SpectFile_popG illinois_sweep.recomb popG_recombcontrolled.sweep


vcftools --vcf illinois_893_miss_indel.recode.vcf --counts --out popD --keep popD
awk '($3 == 2)' popD.frq.count | awk 'split($6,a,":")  {print $2  "\t" a[2] "\t" $4 "\t" "1"}' > popD_AFFsweepfinder.txt
cat /ohta/julia.kreiner/waterhemp/data/finaldata_all/final_bams/pileups/popD_AFFsweepfinder.txt | sed '2995d;10291d;57197d;57198d;57286d;57287d' > popD_AFFsweepfinder_sitesremoved.txt
sed -i '1iposition\tx\tn\tfolded' popD_AFFsweepfinder_sitesremoved.txt
./SweepFinder2 -f popD_AFFsweepfinder_sitesremoved.txt SpectFile_popD
./SweepFinder2 -lr 1000 popD_AFFsweepfinder_sitesremoved.txt SpectFile_popD illinois_sweep.recomb popD_recombcontrolled.sweep


vcftools --vcf illinois_893_miss_indel.recode.vcf --counts --out popF --keep popF
awk '($3 == 2)' popF.frq.count | awk 'split($6,a,":")  {print $2  "\t" a[2] "\t" $4 "\t" "1"}' > popF_AFFsweepfinder.txt
cat /ohta/julia.kreiner/waterhemp/data/finaldata_all/final_bams/pileups/popF_AFFsweepfinder.txt | sed '2995d;10291d;57197d;57198d;57286d;57287d' > popF_AFFsweepfinder_sitesremoved.txt
sed -i '1iposition\tx\tn\tfolded' popF_AFFsweepfinder_sitesremoved.txt
./SweepFinder2 -f popF_AFFsweepfinder_sitesremoved.txt SpectFile_popF
./SweepFinder2 -lr 1000 popF_AFFsweepfinder_sitesremoved.txt SpectFile_popF illinois_sweep.recomb popF_recombcontrolled.sweep
