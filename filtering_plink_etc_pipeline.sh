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


#####################################################################
#plink
#####################################################################
#/ohta/julia.kreiner/waterhemp/analyses/plink/LD/ohta/julia.kreiner/waterhemp/analyses/plink/LD

#vcf to plink bed
/ohta/apps/plink/plink --vcf ontario_all92_missing_indmiss_dustmasked_filtqualbydepth_AB_PS_QUAL_noindels.recode.vcf --out ontario_finalfilt --allow-extra-chr

#vcf to plink map etc.
/ohta/apps/plink/plink --vcf /ohta/julia.kreiner/waterhemp/data/finalvcfs/ontario_all92_missing_indmiss_dustmasked_filtqualbydepth_AB_PS_QUAL_noindels.recode.vcf --maf 0.05 --recode --out ontario_finalfilt_LD --allow-extra-chr

#prune for linkage
/ohta/apps/plink/plink --file ontario_finalfilt_LD --indep 100 10 2 --allow-extra-chr
/ohta/apps/plink/plink --file ontario_finalfilt_LD --extract plink.prune.in --make-bed --out pruneddata --allow-extra-chr

#calculate IBD
/ohta/apps/plink/plink --vcf ~/waterhemp/data/finalvcfs/ontario_all92_missing_indmiss_dustmasked_filtqualbydepth_AB_PS_QUAL_noindels.recode.vcf --extract plink.prune.in --genome --allow-extra-chr --homozyg

/ohta/apps/plink/plink --bfile ontario_finalfilt --allow-extra-chr --homozyg

#calculate inbreeding coefficients 
/ohta/apps/plink/plink --vcf ~/waterhemp/data/finalvcfs/ontario_all92_missing_indmiss_dustmasked_filtqualbydepth_AB_PS_QUAL_noindels.recode.vcf  --extract plink.prune.in --het --allow-extra-chr

#print comparisons within populations only
awk 'split($1,a,"_") {print a[1]"\t"$0}' plink.genome > plink_genome_extra
awk -F'\t' -v OFS='\t' 'NR>1 { $(NF+1)=NR-1} 1' plink_genome_extra > plink_genome_extra_rwos
awk '{print $16"\t"$1"\t"$0}' plink_genome_extra_rwos > plink_genome_match
awk 'split($4,b,"_") {print b[1]"\t"$0}' plink_genome_extra_rwos > plink_genome_match23
awk -F "\t" '($1==$2)' plink_genome_match23 > withinpops

cat <(head -n 1 plink.genome) <(cut -f 3- withinpops) > plink_withinpops


#run PCA
/ohta/apps/plink/plink --vcf ~/waterhemp/data/finalvcfs/ontario_all92_missing_indmiss_dustmasked_filtqualbydepth_AB_PS_QUAL_noindels.recode.vcf --allow-extra-chr --pca --extract plink.prune.in

#run Fst

/ohta/apps/plink/plink --bfile ontario_illinois_filt2 --allow-extra-chr --fst --within twopop


#run clustering for TREEMIX
/ohta/apps/plink/plink --vcf ~/waterhemp/data/finalvcfs/ontario_all92_missing_indmiss_dustmasked_filtqualbydepth_AB_PS_QUAL_noindels.recode.vcf --read-genome plink.genome --allow-extra-chr --cluster & 


#####################################################################
#TREEMIX
#####################################################################

awk '{$2 = $1":"$4; print}' ontario_finalfilt.bim > ontario_finalfilt_2.bim
#make cluster file of 3 columns, pop name, ind name, cluster(values 1:8)
/ohta/apps/plink/plink --bfile ontario_illinois_filt2 --freq --missing --within plink.cluster_redone2 --allow-extra-chr

#get treemix input format from clustered allele frequencies
gzip plink.frq.strat

python /ohta/julia.kreiner/software/nygcresearch-treemix-f38bfada3286/src/plink2treemix.py plink.frq.strat.gz treemix.frq.gz

#run treemix

/ohta/julia.kreiner/software/nygcresearch-treemix-f38bfada3286/src/treemix -i treemix.frq.gz --root 'N1' -k 1000 -bootstrap -o out_stem_N1root
/ohta/julia.kreiner/software/nygcresearch-treemix-f38bfada3286/src/treemix -i treemix.frq.gz --root 'N1' -k 1000 -bootstrap -m 1 -o out_stem_m1 &
/ohta/julia.kreiner/software/nygcresearch-treemix-f38bfada3286/src/treemix -i treemix.frq.gz --root 'N1' -k 1000 -bootstrap -m 2 -o out_stem_m2 &
/ohta/julia.kreiner/software/nygcresearch-treemix-f38bfada3286/src/treemix -i treemix.frq.gz --root 'N1' -k 1000 -bootstrap -m 3 -o out_stem_m3 &
/ohta/julia.kreiner/software/nygcresearch-treemix-f38bfada3286/src/treemix -i treemix.frq.gz --root 'N1' -k 1000 -bootstrap -m 4 -o out_stem_m4 &
/ohta/julia.kreiner/software/nygcresearch-treemix-f38bfada3286/src/treemix -i treemix.frq.gz --root 'N1' -k 1000 -bootstrap -m 5 -o out_stem_m5 &
/ohta/julia.kreiner/software/nygcresearch-treemix-f38bfada3286/src/treemix -i treemix.frq.gz --root 'N1' -k 1000 -bootstrap -m 6 -o out_stem_m6 &

/ohta/julia.kreiner/software/nygcresearch-treemix-f38bfada3286/bin/threepop -i treemix.frq.gz -k 500 > threepop_2.test &
/ohta/julia.kreiner/software/nygcresearch-treemix-f38bfada3286/bin/fourpop -i treemix.frq.gz -k 500 > fourpop.test &


#plot results in R

source("/ohta/julia.kreiner/software/nygcresearch-treemix-f38bfada3286/src/plotting_funcs.R")
pdf("tree.pdf")
plot_tree("out_stem_rootN1")
dev.off()
pdf("tree_resid.pdf")
plot_resid("out_stem_rootN1", "poporder")
dev.off()

#for m=1
source("/ohta/julia.kreiner/software/treemix/src/plotting_funcs.R")
pdf("tree_m1.pdf")
plot_tree("out_stem_m1_rootN1")
dev.off()
pdf("tree_m1_resid.pdf")
plot_resid("out_stem_m1_rootN1", "poporder")
dev.off()

#for m=2
source("/ohta/julia.kreiner/software/nygcresearch-treemix-f38bfada3286/src/plotting_funcs.R")
pdf("tree_m2.pdf")
plot_tree("out_stem_m2_rootN1")
dev.off()
pdf("tree_m2_resid.pdf")
plot_resid("out_stem_m2_rootN1", "poporder")
dev.off()

#for m=3
source("/ohta/julia.kreiner/software/nygcresearch-treemix-f38bfada3286/src/plotting_funcs.R")
pdf("tree_m3.pdf")
plot_tree("out_stem_m3_rootN1")
dev.off()
pdf("tree_m3_resid.pdf")
plot_resid("out_stem_m3_rootN1", "poporder")
dev.off()

#for m=4
source("/ohta/julia.kreiner/software/nygcresearch-treemix-f38bfada3286/src/plotting_funcs.R")
pdf("tree_m4.pdf")
plot_tree("out_stem_m4_rootN1")
dev.off()
pdf("tree_m4_resid.pdf")
plot_resid("out_stem_m4_rootN1", "poporder")
dev.off()

#for m=5
source("/ohta/julia.kreiner/software/nygcresearch-treemix-f38bfada3286/src/plotting_funcs.R")
pdf("tree_m5.pdf")
plot_tree("out_stem_m5_rootN1")
dev.off()
pdf("tree_m5_resid.pdf")
plot_resid("out_stem_m5_rootN1", "poporder")
dev.off()


#for m=6
source("/ohta/julia.kreiner/software/nygcresearch-treemix-f38bfada3286/src/plotting_funcs.R")
pdf("tree_m6.pdf")
plot_tree("out_stem_m6_rootN1")
dev.off()
pdf("tree_m6_resid.pdf")
plot_resid("out_stem_m6_rootN1", "poporder")
dev.off()

pdf("tree_m7.pdf")
plot_tree("out_stem_m7_rootN1")
dev.off()
pdf("tree_m7_resid.pdf")
plot_resid("out_stem_m7_rootN1", "poporder")
dev.off()

pdf("tree_m8.pdf")
plot_tree("out_stem_m8_rootN1")
dev.off()
pdf("tree_m8_resid.pdf")
plot_resid("out_stem_m8_rootN1", "poporder")
dev.off()

pdf("tree_m9.pdf")
plot_tree("out_stem_m9_rootN1")
dev.off()
pdf("tree_m9_resid.pdf")
plot_resid("out_stem_m9_rootN1", "poporder")
dev.off()

pdf("tree_m10.pdf")
plot_tree("out_stem_m10_rootN1")
dev.off()
pdf("tree_m10_resid.pdf")
plot_resid("out_stem_m10_rootN1", "poporder")
dev.off()


#####################################################################
#run fastStructure
#####################################################################

#estimate proportion admixture
python2 ~/software/fastStructure/structure.py -K 2 --input=/ohta/julia.kreiner/waterhemp/analyses/plink/joint_files/ontario_illinois_filt2 --output=/ohta/julia.kreiner/waterhemp/analyses/faststructure/allpops_logistic --full --seed=100 --prior=logistic &
python2 ~/software/fastStructure/structure.py -K 3 --input=/ohta/julia.kreiner/waterhemp/analyses/plink/joint_files/ontario_illinois_filt2 --output=/ohta/julia.kreiner/waterhemp/analyses/faststructure/allpops_logistic --full --seed=100 --prior=logistic &
python2 ~/software/fastStructure/structure.py -K 4 --input=/ohta/julia.kreiner/waterhemp/analyses/plink/joint_files/ontario_illinois_filt2 --output=/ohta/julia.kreiner/waterhemp/analyses/faststructure/allpops_logistic --full --seed=100 --prior=logistic &
python2 ~/software/fastStructure/structure.py -K 5 --input=/ohta/julia.kreiner/waterhemp/analyses/plink/joint_files/ontario_illinois_filt2 --output=/ohta/julia.kreiner/waterhemp/analyses/faststructure/allpops_logistic --full --seed=100 --prior=logistic &
python2 ~/software/fastStructure/structure.py -K 6 --input=/ohta/julia.kreiner/waterhemp/analyses/plink/joint_files/ontario_illinois_filt2 --output=/ohta/julia.kreiner/waterhemp/analyses/faststructure/allpops_logistic --full --seed=100 --prior=logistic &
python2 ~/software/fastStructure/structure.py -K 7 --input=/ohta/julia.kreiner/waterhemp/analyses/plink/joint_files/ontario_illinois_filt2 --output=/ohta/julia.kreiner/waterhemp/analyses/faststructure/allpops_logistic --full --seed=100 --prior=logistic &
python2 ~/software/fastStructure/structure.py -K 8 --input=/ohta/julia.kreiner/waterhemp/analyses/plink/joint_files/ontario_illinois_filt2 --output=/ohta/julia.kreiner/waterhemp/analyses/faststructure/allpops_logistic --full --seed=100 --prior=logistic &
python2 ~/software/fastStructure/structure.py -K 9 --input=/ohta/julia.kreiner/waterhemp/analyses/plink/joint_files/ontario_illinois_filt2 --output=/ohta/julia.kreiner/waterhemp/analyses/faststructure/allpops_logistic --full --seed=100 --prior=logistic &
python2 ~/software/fastStructure/structure.py -K 10 --input=/ohta/julia.kreiner/waterhemp/analyses/plink/joint_files/ontario_illinois_filt2 --output=/ohta/julia.kreiner/waterhemp/analyses/faststructure/allpops_logistic --full --seed=100 --prior=logistic &

#choose model complexity
python2 ~/software/fastStructure/chooseK.py --input=allpops_simple

#visualize admixture proportions
#had to put "import matplotlib ,matplotlib.use('agg')" at beginning of script

python2 ~/software/fastStructure/distruct.py -K 2 --input=allpops_simple --popfile=popmap --output=ontario_illinois_simple_distruct_K2.svg



############
#running faststructure on just HTG_893 - does admixture look simiar to genome wide?
######

#do a lil bit of filtering first from samtools mpileup/bcftools called snps

vcffilter -f "QUAL > 30" illinois_893.vcf.gz > illinois_893_qual30.vcf
vcffilter -f "QUAL > 30" ontario_893.vcf.gz > ontario_893_qual30.vcf

bgzip -c illinois_893_qual30.vcf > illinois_893_qual30.vcf.gz &
bgzip -c ontario_893_qual30.vcf > ontario_893_qual30.vcf.gz &
tabix -p vcf illinois_893_qual30.vcf.gz &
tabix -p vcf ontario_893_qual30.vcf.gz &

vcf-merge illinois_893_qual30.vcf.gz ontario_893_qual30.vcf.gz > ontario_illinois_893_qual30.vcf
#or
vcffilter -f "QUAL > 30" ontario_illinois_893_missindels.recode.vcf > ontario_illinois_893_missindels_qual30.vcf

#conver to plink
/ohta/apps/plink/plink --vcf ontario_illinois_893_qual30.vcf --out plink_893/ontario_illinois_893_qual30 --allow-extra-chr --double-id

#run faststruct
python2 ~/software/fastStructure/structure.py -K 2 --input=/ohta/julia.kreiner/waterhemp/data/finaldata_all/final_bams/pileups/plink_893/ontario_illinois_893_qual30 --output=/ohta/julia.kreiner/waterhemp/data/finaldata_all/final_bams/pileups/plink_893/structure_results/ont_ill_logistic --full --seed=100 --prior=logistic &

python2 ~/software/fastStructure/structure.py -K 3 --input=/ohta/julia.kreiner/waterhemp/data/finaldata_all/final_bams/pileups/plink_893/ontario_illinois_893_qual30 --output=/ohta/julia.kreiner/waterhemp/data/finaldata_all/final_bams/pileups/plink_893/structure_results/ont_ill_logistic --full --seed=100 --prior=logistic &

python2 ~/software/fastStructure/structure.py -K 4 --input=/ohta/julia.kreiner/waterhemp/data/finaldata_all/final_bams/pileups/plink_893/ontario_illinois_893_qual30 --output=/ohta/julia.kreiner/waterhemp/data/finaldata_all/final_bams/pileups/plink_893/structure_results/ont_ill_logistic --full --seed=100 --prior=logistic &

python2 ~/software/fastStructure/structure.py -K 5 --input=/ohta/julia.kreiner/waterhemp/data/finaldata_all/final_bams/pileups/plink_893/ontario_illinois_893_qual30 --output=/ohta/julia.kreiner/waterhemp/data/finaldata_all/final_bams/pileups/plink_893/structure_results/ont_ill_logistic --full --seed=100 --prior=logistic &

python2 ~/software/fastStructure/structure.py -K 6 --input=/ohta/julia.kreiner/waterhemp/data/finaldata_all/final_bams/pileups/plink_893/ontario_illinois_893_qual30 --output=/ohta/julia.kreiner/waterhemp/data/finaldata_all/final_bams/pileups/plink_893/structure_results/ont_ill_logistic --full --seed=100 --prior=logistic &

python2 ~/software/fastStructure/structure.py -K 7 --input=/ohta/julia.kreiner/waterhemp/data/finaldata_all/final_bams/pileups/plink_893/ontario_illinois_893_qual30 --output=/ohta/julia.kreiner/waterhemp/data/finaldata_all/final_bams/pileups/plink_893/structure_results/ont_ill_logistic --full --seed=100 --prior=logistic &

python2 ~/software/fastStructure/structure.py -K 8 --input=/ohta/julia.kreiner/waterhemp/data/finaldata_all/final_bams/pileups/plink_893/ontario_illinois_893_qual30 --output=/ohta/julia.kreiner/waterhemp/data/finaldata_all/final_bams/pileups/plink_893/structure_results/ont_ill_logistic --full --seed=100 --prior=logistic &

python2 ~/software/fastStructure/structure.py -K 9 --input=/ohta/julia.kreiner/waterhemp/data/finaldata_all/final_bams/pileups/plink_893/ontario_illinois_893_qual30 --output=/ohta/julia.kreiner/waterhemp/data/finaldata_all/final_bams/pileups/plink_893/structure_results/ont_ill_logistic --full --seed=100 --prior=logistic &

####################################################################
#run beagle
#####################################################################

#replace missing data calls to look like a diploid
#cat ontario_illinois_allfiltered.vcf | perl -pe "s/\s\.:/\t.\/.:/g" | perl -pe "s/\s\./\t.\/.:.:.:.:.:.:./g" > ont_ill_missingreplaced_2.vcf &


#awk -F "\t" '{for(i=10;i<=NF;i++) if ($i==".") $i == "./.:.:.:.:.:.:." ; print }' ontario_illinois_allfiltered.vcf
#cut -f10- ontario_illinois_allfiltered.vcf | perl -pe "s/\s\.:.:.:.:.:.:./\t.\/.:.:.:.:.:.:./g" | perl -pe "s/\s\./\t.\/.:.:.:.:.:.:./g" > ont_ill_missingreplaced_justcalls.vcf

#paste <( cut -f-9 ontario_illinois_allfiltered.vcf) ont_ill_missingreplaced_justcalls.vcf > test

java -Xmx10g -jar /ohta/julia.kreiner/software/beagle.27Jan18.7e1.jar gt=ontartio_illinois_IBDtracts.vcf.gz ibd=true impute=false out=ontario_illinois_IBDtracts_redo nthreads=25


grep -v "#" ontario_illinois_allfiltered.vcf | awk '{print $1}' |uniq > contigs


while read contig
do

java -jar ~/software/ibdseq.r1206.jar gt=ont_ill_missingreplaced.vcf out=OI_ibdseq_${contig} nthreads=10 chrom=${contig}

done < contigs &
