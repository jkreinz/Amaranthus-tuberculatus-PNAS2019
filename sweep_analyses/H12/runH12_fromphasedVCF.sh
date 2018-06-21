#Julia Kreiner, June 2018
#Format H12 input file from VCF


###########
/#HTG_893
###########

#do for R and S inds (SUSCEPTIBLE HERE)
#start here
vcftools --gzvcf 893_phased.vcf.gz --recode --out 893_phased_essex --keep essex_reference.txt
awk -f H12_dependency.awk 893_phased_essex.recode.vcf > 893_essex.phasedalleles
sed ':a;N;$!ba;s/,\n/\n/g' 893_essex.phasedalleles > 893_essex_cor.phasedalleles
tail -n +12 893_essex_cor.phasedalleles > 893_essex_cor_final.phasedalleles
#fix by hand
awk -F "," 'BEGIN{OFS=","} {if(NF=25); print $0}' 893_essex_cor_final.phasedalleles > 893_essex_n24.phasedalleles
sed -e "s/,\+/,/g" -e "s/,$//" 893_essex_n24.phasedalleles | awk -F "," 'NF==25' > 893_essex_n24_corr.phasedalleles
#try this
#tail -n +40000 893_essex_n80.phasedalleles | head -n 70000 > 893_essex_n80_trunc.phasedalleles
#with hamming = 3
python2 ~/software/SelectionHapStats/scripts/H12_H2H1.py 893_essex_n24_corr.phasedalleles 24 -o essexEPSPS_d3.h12 -w 100 -j 25 -d 0
python2 ~/software/SelectionHapStats/scripts/H12peakFinder.py essexEPSPS_d3.h12 -o essexEPSPS_d3.peaks
Rscript ~/software/SelectionHapStats/scripts/H12_viz.R essexEPSPS_d3.h12 essexEPSPS_d3.peaks essexEPSPS_d3_H12scan.pdf 10
Rscript ~/software/SelectionHapStats/scripts/hapSpectrum_viz.R essexEPSPS_d3.peaks essexEPSPS_d3_spectrum.pdf 10 80
#with hamming = 4
python2 ~/software/SelectionHapStats/scripts/H12_H2H1.py 893_essex_n80_corr.phasedalleles 80 -o essexEPSPS_d4.h12 -w 100 -j 25 -d 4
python2 ~/software/SelectionHapStats/scripts/H12peakFinder.py essexEPSPS_d4.h12 -o essexEPSPS_d4.peaks
Rscript ~/software/SelectionHapStats/scripts/H12_viz.R essexEPSPS_d4.h12 essexEPSPS_d4.peaks essexEPSPS_d4_H12scan.pdf 10
Rscript ~/software/SelectionHapStats/scripts/hapSpectrum_viz.R essexEPSPS_d4.peaks essexEPSPS_d4_spectrum.pdf 10 80


#do for R and S inds (SUSCEPTIBLE HERE)
#start here
vcftools --gzvcf 893_phased.vcf.gz --recode --out 893_phased_essex --keep essex_selected.txt # selected actually = susceptible
awk -f H12_dependency.awk 893_phased_essex.recode.vcf > 893_essex.phasedalleles
sed ':a;N;$!ba;s/,\n/\n/g' 893_essex.phasedalleles > 893_essex_cor.phasedalleles
tail -n +12 893_essex_cor.phasedalleles > 893_essex_cor_final.phasedalleles
#fix by hand
awk -F "," 'BEGIN{OFS=","} {if(NF=57); print $0}' 893_essex_cor_final.phasedalleles > 893_essex_n56.phasedalleles
sed -e "s/,\+/,/g" -e "s/,$//" 893_essex_n56.phasedalleles | awk -F "," 'NF==57' > 893_essex_n56_corr.phasedalleles
#try this
#tail -n +40000 893_essex_n80.phasedalleles | head -n 70000 > 893_essex_n80_trunc.phasedalleles
#with hamming = 3
python2 ~/software/SelectionHapStats/scripts/H12_H2H1.py 893_essex_n56_corr.phasedalleles 56 -o essexEPSPS_selected_d0.h12 -w 150 -j 50 
python2 ~/software/SelectionHapStats/scripts/H12peakFinder.py essexEPSPS_selected_d0.h12 -o essexEPSPS_selected_d0.peaks
Rscript ~/software/SelectionHapStats/scripts/H12_viz.R essexEPSPS_selected_d0.h12 essexEPSPS_selected_d0.peaks essexEPSPS_selected_d0_H12scan.pdf 10
Rscript ~/software/SelectionHapStats/scripts/hapSpectrum_viz.R essexEPSPS_selected_d0.peaks essexEPSPS_selected_d0_spectrum.pdf 10 56


#ESSEX SUSCEPTIBLE
vcftools --gzvcf 893_phased.vcf.gz --recode --out 893_phased_essex --keep essex_reference.txt #crap switched the labels, reference = sus
awk -f H12_dependency.awk 893_phased_essex.recode.vcf > 893_essex.phasedalleles
sed ':a;N;$!ba;s/,\n/\n/g' 893_essex.phasedalleles > 893_essex_cor.phasedalleles
tail -n +12 893_essex_cor.phasedalleles > 893_essex_cor_final.phasedalleles
#fix by hand
awk -F "," 'BEGIN{OFS=","} {if(NF=25); print $0}' 893_essex_cor_final.phasedalleles > 893_essex_n24.phasedalleles
sed -e "s/,\+/,/g" -e "s/,$//" 893_essex_n24.phasedalleles | awk -F "," 'NF==25' > 893_essex_n24_corr.phasedalleles
#try this
#tail -n +40000 893_essex_n80.phasedalleles | head -n 70000 > 893_essex_n80_trunc.phasedalleles
#with hamming = 3
python2 ~/software/SelectionHapStats/scripts/H12_H2H1.py 893_essex_n24_corr.phasedalleles 24 -o essexEPSPS_ref_d0.h12 -w 150 -j 50
python2 ~/software/SelectionHapStats/scripts/H12peakFinder.py essexEPSPS_ref_d0.h12 -o essexEPSPS_ref_d0.peaks
Rscript ~/software/SelectionHapStats/scripts/H12_viz.R essexEPSPS_ref_d0.h12 essexEPSPS_ref_d0.peaks essexEPSPS_ref_d0_H12scan.pdf 10
Rscript ~/software/SelectionHapStats/scripts/hapSpectrum_viz.R essexEPSPS_ref_d0.peaks essexEPSPS_ref_d0_spectrum.pdf 10 24





#WALPOLE SELECTED
vcftools --gzvcf 893_phased.vcf.gz --recode --out 893_phased_walpole --keep walpole_selected.txt
awk -f H12_dependency.awk 893_phased_walpole.recode.vcf > 893_walpole.phasedalleles
sed ':a;N;$!ba;s/,\n/\n/g' 893_walpole.phasedalleles > 893_walpole_cor.phasedalleles
tail -n +12 893_walpole_cor.phasedalleles > 893_walpole_cor_final.phasedalleles
#fix by hand
awk -F "," 'BEGIN{OFS=","} {if(NF=35); print $0}' 893_walpole_cor_final.phasedalleles > 893_walpole_n34.phasedalleles
sed -e "s/,\+/,/g" -e "s/,$//" 893_walpole_n34.phasedalleles | awk -F "," 'NF==35' > 893_walpole_n34_corr.phasedalleles
#try this
#tail -n +40000 893_walpole_n84.phasedalleles | head -n 70000 > 893_walpole_n84_trunc.phasedalleles
#with hamming = 3
python2 ~/software/SelectionHapStats/scripts/H12_H2H1.py 893_walpole_n34_corr.phasedalleles 34 -o walpoleEPSPS_selected_d0.h12 -w 150 -j 50 
python2 ~/software/SelectionHapStats/scripts/H12peakFinder.py walpoleEPSPS_selected_d0.h12 -o walpoleEPSPS_selected_d0.peaks
Rscript ~/software/SelectionHapStats/scripts/H12_viz.R walpoleEPSPS_selected_d0.h12 walpoleEPSPS_selected_d0.peaks walpoleEPSPS_selected_d0_H12scan.pdf 10
Rscript ~/software/SelectionHapStats/scripts/hapSpectrum_viz.R walpoleEPSPS_selected_d0.peaks walpoleEPSPS_selected_d0_spectrum.pdf 10 34
#with hamming = 4
#python2 ~/software/SelectionHapStats/scripts/H12_H2H1.py 893_walpole_n84_corr.phasedalleles 84 -o walpoleEPSPS_d4.h12 -w 100 -j 25 -d 4
#python2 ~/software/SelectionHapStats/scripts/H12peakFinder.py walpoleEPSPS_d4.h12 -o walpoleEPSPS_d4.peaks
#Rscript ~/software/SelectionHapStats/scripts/H12_viz.R walpoleEPSPS_d4.h12 walpoleEPSPS_d4.peaks walpoleEPSPS_d4_H12scan.pdf 10
#Rscript ~/software/SelectionHapStats/scripts/hapSpectrum_viz.R walpoleEPSPS_d4.peaks walpoleEPSPS_d4_spectrum.pdf 10 84

#WALPOLE REFERENCE
vcftools --gzvcf 893_phased.vcf.gz --recode --out 893_phased_walpole --keep walpole_reference.txt
awk -f H12_dependency.awk 893_phased_walpole.recode.vcf > 893_walpole.phasedalleles
sed ':a;N;$!ba;s/,\n/\n/g' 893_walpole.phasedalleles > 893_walpole_cor.phasedalleles
tail -n +12 893_walpole_cor.phasedalleles > 893_walpole_cor_final.phasedalleles
#fix by hand
awk -F "," 'BEGIN{OFS=","} {if(NF=51); print $0}' 893_walpole_cor_final.phasedalleles > 893_walpole_n50.phasedalleles
sed -e "s/,\+/,/g" -e "s/,$//" 893_walpole_n84.phasedalleles | awk -F "," 'NF==51' > 893_walpole_n50_corr.phasedalleles
#try this
#tail -n +40000 893_walpole_n84.phasedalleles | head -n 70000 > 893_walpole_n84_trunc.phasedalleles
#with hamming = 3
python2 ~/software/SelectionHapStats/scripts/H12_H2H1.py 893_walpole_n84_corr.phasedalleles 50 -o walpoleEPSPS_ref_d0.h12 -w 150 -j 50
python2 ~/software/SelectionHapStats/scripts/H12peakFinder.py walpoleEPSPS_ref_d0.h12 -o walpoleEPSPS_ref_d0.peaks
Rscript ~/software/SelectionHapStats/scripts/H12_viz.R walpoleEPSPS_ref_d0.h12 walpoleEPSPS_ref_d0.peaks walpoleEPSPS_ref_d0_H12scan.pdf 10
Rscript ~/software/SelectionHapStats/scripts/hapSpectrum_viz.R walpoleEPSPS_ref_d0.peaks walpoleEPSPS_ref_d0_spectrum.pdf 10 50
#with hamming = 4
#python2 ~/software/SelectionHapStats/scripts/H12_H2H1.py 893_walpole_n84_corr.phasedalleles 84 -o walpoleEPSPS_d4.h12 -w 100 -j 25 -d 4
#python2 ~/software/SelectionHapStats/scripts/H12peakFinder.py walpoleEPSPS_d4.h12 -o walpoleEPSPS_d4.peaks
#Rscript ~/software/SelectionHapStats/scripts/H12_viz.R walpoleEPSPS_d4.h12 walpoleEPSPS_d4.peaks walpoleEPSPS_d4_H12scan.pdf 10
#Rscript ~/software/SelectionHapStats/scripts/hapSpectrum_viz.R walpoleEPSPS_d4.peaks walpoleEPSPS_d4_spectrum.pdf 10 84

#ILLINOIS
#just resistant individuals
vcftools --gzvcf 893_phased.vcf.gz --recode --out 893_phased_illinois --keep illinois_resistant.txt
awk -f H12_dependency.awk 893_phased_illinois.recode.vcf > 893_illinois.phasedalleles
sed ':a;N;$!ba;s/,\n/\n/g' 893_illinois.phasedalleles > 893_illinois_cor.phasedalleles
tail -n +12 893_illinois_cor.phasedalleles > 893_illinois_cor_final.phasedalleles
#fix by hand
awk -F "," 'BEGIN{OFS=","} {if(NF=85); print $0}' 893_illinois_cor_final.phasedalleles > 893_illinois_n80.phasedalleles
sed -e "s/,\+/,/g" -e "s/,$//" 893_illinois_n80.phasedalleles | awk -F "," 'NF==85' > 893_illinois_n80_corr.phasedalleles
#tail -n +60000 893_illinois_n80.phasedalleles | head -n 400000 > 893_illinois_n80_trunc.phasedallelestail -n +100000 893_illinois_n80.phasedalleles | head -n 100000 > 893_illinois_n80_trunc.phasedalleles
#tail -n +60000 893_illinois_n80.phasedalleles | head -n 50000 > 893_illinois_n80_trunc.phasedalleles
#with hamming = 3
python2 ~/software/SelectionHapStats/scripts/H12_H2H1.py 893_illinois_n80_corr.phasedalleles 84 -o illinoisEPSPS_selected_d0.h12 -w 150 -j 50
python2 ~/software/SelectionHapStats/scripts/H12peakFinder.py illinoisEPSPS_selected_d0.h12 -o illinoisEPSPS_selected_d0.peaks
Rscript ~/software/SelectionHapStats/scripts/H12_viz.R illinoisEPSPS_selected_d0.h12 illinoisEPSPS_selected_d0.peaks illinoisEPSPS_selected_d0_H12scan.pdf 10
Rscript ~/software/SelectionHapStats/scripts/hapSpectrum_viz.R illinoisEPSPS_selected_d0.peaks illinoisEPSPS_selected_d0_spectrum.pdf 10 84


#just susceptible individuals
vcftools --gzvcf 893_phased.vcf.gz --recode --out 893_phased_illinois --keep illinois_ref.txt
awk -f H12_dependency.awk 893_phased_illinois.recode.vcf > 893_illinois.phasedalleles
sed ':a;N;$!ba;s/,\n/\n/g' 893_illinois.phasedalleles > 893_illinois_cor.phasedalleles
tail -n +12 893_illinois_cor.phasedalleles > 893_illinois_cor_final.phasedalleles
#fix by hand
awk -F "," 'BEGIN{OFS=","} {if(NF=63); print $0}' 893_illinois_cor_final.phasedalleles > 893_illinois_n62.phasedalleles
sed -e "s/,\+/,/g" -e "s/,$//" 893_illinois_n62.phasedalleles | awk -F "," 'NF==63' > 893_illinois_n62_corr.phasedalleles
#tail -n +60000 893_illinois_n80.phasedalleles | head -n 400000 > 893_illinois_n80_trunc.phasedallelestail -n +100000 893_illinois_n80.phasedalleles | head -n 100000 > 893_illinois_n80_trunc.phasedalleles
#tail -n +60000 893_illinois_n80.phasedalleles | head -n 50000 > 893_illinois_n80_trunc.phasedalleles
#with hamming = 3
python2 ~/software/SelectionHapStats/scripts/H12_H2H1.py 893_illinois_n62_corr.phasedalleles 62 -o illinoisEPSPS_ref_d0.h12 -w 150 -j 50
python2 ~/software/SelectionHapStats/scripts/H12peakFinder.py illinoisEPSPS_ref_d0.h12 -o illinoisEPSPS_ref_d0.peaks
Rscript ~/software/SelectionHapStats/scripts/H12_viz.R illinoisEPSPS_ref_d0.h12 illinoisEPSPS_ref_d0.peaks illinoisEPSPS_ref_d0_H12scan.pdf 10
Rscript ~/software/SelectionHapStats/scripts/hapSpectrum_viz.R illinoisEPSPS_ref_d0.peaks illinoisEPSPS_ref_d0_spectrum.pdf 10 62





#all samples
vcftools --gzvcf 893_phased.vcf.gz --recode --out 893_phased_illinois2 --keep illinois
awk -f H12_dependency.awk 893_phased_illinois2.recode.vcf > 893_illinois2.phasedalleles
sed ':a;N;$!ba;s/,\n/\n/g' 893_illinois2.phasedalleles > 893_illinois2_cor.phasedalleles
tail -n +12 893_illinois2_cor.phasedalleles > 893_illinois2_cor_final.phasedalleles
#fix by hand
awk -F "," 'BEGIN{OFS=","} {if(NF=147); print $0}' 893_illinois2_cor_final.phasedalleles > 893_illinois2_n146.phasedalleles
#tail -n +60000 893_illinois_n80.phasedalleles | head -n 400000 > 893_illinois_n80_trunc.phasedalleles
#tail -n +75000 893_illinois2_n80.phasedalleles | head -n 15000 > 893_illinois2_n80_trunc.phasedalleles
#tail -n +50000 893_illinois2_n146.phasedalleles | head -n 75000 > 893_illinois2_n146_trunc.phasedalleles
sed -e "s/,\+/,/g" -e "s/,$//" 893_illinois2_n146.phasedalleles | awk -F "," 'NF==147' > 893_illinois2_n146_corr.phasedalleles
python2 ~/software/SelectionHapStats/scripts/H12_H2H1.py 893_illinois2_n146_corr.phasedalleles 146 -o illinois2EPSPS_d3.h12 -w 100 -j 25 -d 3
python2 ~/software/SelectionHapStats/scripts/H12peakFinder.py illinois2EPSPS_d3.h12 -o illinois2EPSPS_d3.peaks
Rscript ~/software/SelectionHapStats/scripts/H12_viz.R illinois2EPSPS_d3.h12 illinois2EPSPS_d3.peaks illinois2EPSPS_d3_H12scan.pdf 10
Rscript ~/software/SelectionHapStats/scripts/hapSpectrum_viz.R illinois2EPSPS_d3.peaks illinois2EPSPS_d3_spectrum.pdf 10 146
#with hamming=4
python2 ~/software/SelectionHapStats/scripts/H12_H2H1.py 893_illinois2_n146_corr.phasedalleles 146 -o illinois2EPSPS_d4.h12 -w 100 -j 25 -d 4
python2 ~/software/SelectionHapStats/scripts/H12peakFinder.py illinois2EPSPS_d4.h12 -o illinois2EPSPS_d4.peaks
Rscript ~/software/SelectionHapStats/scripts/H12_viz.R illinois2EPSPS_d4.h12 illinois2EPSPS_d4.peaks illinois2EPSPS_d4_H12scan.pdf 10
Rscript ~/software/SelectionHapStats/scripts/hapSpectrum_viz.R illinois2EPSPS_d4.peaks illinois2EPSPS_d4_spectrum.pdf 10 146




#CENTER OVER ALL:

#centered, d4
python2 ~/software/SelectionHapStats/scripts/H12_H2H1.py 893_essex_n80_corr.phasedalleles 80 -o essexEPSPS_d4_centered.h12 -w 100 -j 25 -d 4 -s 398424
Rscript ~/software/SelectionHapStats/scripts/hapSpectrum_viz.R essexEPSPS_d4_centered.h12 essexEPSPS_d4_centered_spectrum.pdf 1 80

python2 ~/software/SelectionHapStats/scripts/H12_H2H1.py 893_walpole_n84_corr.phasedalleles 84 -o walpoleEPSPS_d4_centered.h12 -w 100 -j 25 -d 4 -s 398424
Rscript ~/software/SelectionHapStats/scripts/hapSpectrum_viz.R walpoleEPSPS_d4_centered.h12 walpoleEPSPS_d4_centered_spectrum.pdf 1 84

python2 ~/software/SelectionHapStats/scripts/H12_H2H1.py 893_illinois2_n146_corr.phasedalleles 146 -o illinois2EPSPS_d4_centered.h12 -w 100 -j 25 -d 4 -s 398424
Rscript ~/software/SelectionHapStats/scripts/hapSpectrum_viz.R illinois2EPSPS_d4_centered.h12 illinois2EPSPS_d4_centered_spectrum.pdf 1 146

#centered, d5
python2 ~/software/SelectionHapStats/scripts/H12_H2H1.py 893_essex_n80_corr.phasedalleles 80 -o essexEPSPS_d5_centered.h12 -w 100 -j 25 -d 5 -s 398424
Rscript ~/software/SelectionHapStats/scripts/hapSpectrum_viz.R essexEPSPS_d5_centered.h12 essexEPSPS_d5_centered_spectrum.pdf 1 80

python2 ~/software/SelectionHapStats/scripts/H12_H2H1.py 893_walpole_n84_corr.phasedalleles 84 -o walpoleEPSPS_d5_centered.h12 -w 100 -j 25 -d 5 -s 398424
Rscript ~/software/SelectionHapStats/scripts/hapSpectrum_viz.R walpoleEPSPS_d5_centered.h12 walpoleEPSPS_d5_centered_spectrum.pdf 1 84

python2 ~/software/SelectionHapStats/scripts/H12_H2H1.py 893_illinois2_n146_corr.phasedalleles 146 -o illinois2EPSPS_d5_centered.h12 -w 100 -j 25 -d 5 -s 398424
Rscript ~/software/SelectionHapStats/scripts/hapSpectrum_viz.R illinois2EPSPS_d5_centered.h12 illinois2EPSPS_d5_centered_spectrum.pdf 1 146



###########
#HTG_2153
###########


#start here
vcftools --gzvcf 2153_phased.vcf.gz --recode --out 2153_phased_essex --keep essex
awk -f H12_dependency.awk 2153_phased_essex.recode.vcf > 2153_essex.phasedalleles
sed ':a;N;$!ba;s/,\n/\n/g' 2153_essex.phasedalleles > 2153_essex_cor.phasedalleles
tail -n +12 2153_essex_cor.phasedalleles > 2153_essex_cor_final.phasedalleles
#fix by hand
awk -F "," 'BEGIN{OFS=","} {if(NF=81); print $0}' 2153_essex_cor_final.phasedalleles > 2153_essex_n80.phasedalleles
#tail -n +950000 2153_essex_n80.phasedalleles | head -n 150000 > 2153_essex_n80_trunc.phasedalleles
sed -e "s/,\+/,/g" -e "s/,$//" 2153_essex_n80.phasedalleles | awk -F "," 'NF==81' > 2153_essex_n80_cor.phasedalleles
tail -n +800000 2153_essex_n80_cor.phasedalleles | head -n 600000 > 2153_essex_n80_trunc.phasedalleles
python2 ~/software/SelectionHapStats/scripts/H12_H2H1.py 2153_essex_n80_trunc.phasedalleles 80 -o essexALS_d3.h12 -w 100 -j 25 -d 3 
python2 ~/software/SelectionHapStats/scripts/H12peakFinder.py essexALS_d3.h12 -o essexALS_d3.peaks
Rscript ~/software/SelectionHapStats/scripts/H12_viz.R essexALS_d3.h12 essexALS_d3.peaks essexALS_d3_H12scan.pdf 10
Rscript ~/software/SelectionHapStats/scripts/hapSpectrum_viz.R essexALS_d3.peaks essexALS_d3_spectrum.pdf 10 80
#hamming = 1
python2 ~/software/SelectionHapStats/scripts/H12_H2H1.py 2153_essex_n80_trunc.phasedalleles 80 -o essexALS_d1.h12 -w 100 -j 25 -d 1
python2 ~/software/SelectionHapStats/scripts/H12peakFinder.py essexALS_d1.h12 -o essexALS_d1.peaks
Rscript ~/software/SelectionHapStats/scripts/H12_viz.R essexALS_d1.h12 essexALS_d1.peaks essexALS_d1_H12scan.pdf 10
Rscript ~/software/SelectionHapStats/scripts/hapSpectrum_viz.R essexALS_d1.peaks essexALS_d1_spectrum.pdf 10 80
#hamming = 0
python2 ~/software/SelectionHapStats/scripts/H12_H2H1.py 2153_essex_n80_trunc.phasedalleles 80 -o essexALS_d0.h12 -w 100 -j 25 -d 0
python2 ~/software/SelectionHapStats/scripts/H12peakFinder.py essexALS_d0.h12 -o essexALS_d0.peaks
Rscript ~/software/SelectionHapStats/scripts/H12_viz.R essexALS_d0.h12 essexALS_d0.peaks essexALS_d0_H12scan.pdf 10
Rscript ~/software/SelectionHapStats/scripts/hapSpectrum_viz.R essexALS_d0.peaks essexALS_d0_spectrum.pdf 10 80


#WALPOLE
vcftools --gzvcf 2153_phased.vcf.gz --recode --out 2153_phased_walpole --keep walpole
awk -f H12_dependency.awk 2153_phased_walpole.recode.vcf > 2153_walpole.phasedalleles
sed ':a;N;$!ba;s/,\n/\n/g' 2153_walpole.phasedalleles > 2153_walpole_cor.phasedalleles
tail -n +12 2153_walpole_cor.phasedalleles > 2153_walpole_cor_final.phasedalleles
#fix by hand
awk -F "," 'BEGIN{OFS=","} {if(NF=85); print $0}' 2153_walpole_cor_final.phasedalleles > 2153_walpole_n84.phasedalleles
sed -e "s/,\+/,/g" -e "s/,$//" 2153_walpole_n84.phasedalleles | awk -F "," 'NF==85' > 2153_walpole_n84_cor.phasedalleles
tail -n +800000 2153_walpole_n84_cor.phasedalleles | head -n 600000 > 2153_walpole_n84_trunc.phasedalleles
python2 ~/software/SelectionHapStats/scripts/H12_H2H1.py 2153_walpole_n84_trunc.phasedalleles 84 -o walpoleALS_d3.h12 -w 100 -j 25 -d 0
python2 ~/software/SelectionHapStats/scripts/H12peakFinder.py walpoleALS.h12 -o walpoleALS.peaks
Rscript ~/software/SelectionHapStats/scripts/H12_viz.R walpoleALS.h12 walpoleALS.peaks walpoleALS_H12scan.pdf 10
Rscript ~/software/SelectionHapStats/scripts/hapSpectrum_viz.R walpoleALS.peaks walpoleALS_spectrum.pdf 10 84
#hamming = 1


vcftools --gzvcf 2153_phased.vcf.gz --recode --out 2153_phased_illinois --keep illinois
awk -f H12_dependency.awk 2153_phased_illinois.recode.vcf > 2153_illinois.phasedalleles
sed ':a;N;$!ba;s/,\n/\n/g' 2153_illinois.phasedalleles > 2153_illinois_cor.phasedalleles
tail -n +12 2153_illinois_cor.phasedalleles > 2153_illinois_cor_final.phasedalleles
#fix by hand
awk -F "," 'BEGIN{OFS=","} {if(NF=147); print $0}' 2153_illinois_cor_final.phasedalleles > 2153_illinois_n146.phasedalleles
sed -e "s/,\+/,/g" -e "s/,$//" 2153_illinois_n146.phasedalleles | awk -F "," 'NF==147' > 2153_illinois_n146_cor.phasedalleles
tail -n +800000 2153_illinois_n146_cor.phasedalleles | head -n 600000 > 2153_illinois_n146_trunc.phasedalleles
python2 ~/software/SelectionHapStats/scripts/H12_H2H1.py 2153_illinois_n146_trunc.phasedalleles 146 -o illinoisALS.h12 -w 100 -j 25 -d 0
python2 ~/software/SelectionHapStats/scripts/H12peakFinder.py illinoisALS.h12 -o illinoisALS.peaks
Rscript ~/software/SelectionHapStats/scripts/H12_viz.R illinoisALS.h12 illinoisALS.peaks illinoisALS_H12scan.pdf 10
Rscript ~/software/SelectionHapStats/scripts/hapSpectrum_viz.R illinoisALS.peaks illinoisALS_spectrum.pdf 10 80



