#Julia Kreiner, June 2018
#pipeline for running genomics general scripts (https://github.com/simonhmartin/genomics_general)

####################################################################
#get summary and introgression stats
####################################################################

python2 parseVCF.py -i ../allsamples_893_missing.recode.vcf  > HTG893.geno &

#awk -F '\t' 'NR==FNR{c[$1$2]++;next};c[$1$2] > 0' hypo.geno  > tuberc_matchedhypo2.geno &

cat both2.geno | sed "s/N\/N\/N\/N/N\/N/g" > both3.geno

#sliding windows (full)
python2 ../popgenWindows.py -w 100000 --minSites 4000 -g both3.geno -o popgenstats_4pops_1KB_moremissing.csv -f phased -T 5 -p walpole 15_10,15_11,15_3,15_5,15_6,15_7,16_2,16_3,16_7,16_8,17_10,17_11,17_1,17_3,17_4,17_6,17_7,17_9,18_11,18_15,18_16,18_1,18_2,18_3,19_1_1,19_1_3,19_3,19_4,19_5,27_10,27_2,27_3,27_4,27_5,27_6,27_8,27_9 -p natural N/N1_1,N/N1_2,N/N1_3,N/N1_5,N/N1_6,N/N3_1,N/N3_2,N/N3_3,N/N4_2,N/N4_3 -p essex 4_11,4_12,4_13,4_16,4_18,4_1,4_2,4_8,4_9,5_10,5_15,5_19,5_2,5_4,5_7,5_8,6_10,6_2,6_3,6_5,6_6,6_7,6_9,7_10,7_12,7_14,7_2,7_5,7_7,9_10,9_11,9_1,9_4,9_5,9_6,9_7,9_9 -p illinois B10,B11,B13,B16,B19,B1,B3,B4,B7,B9,D10,D11,D12,D14,D15,D1,D2,D4,D5,D6,E10,E14,E15,E19,E2,E3,E6,E7,F10,F11,F12,F13,F1,F4,F5,F7,F9,G10,G11,G13,G15,G2,G5,G7,H10,H11,H14,H1,H2,H4,H6,H8,H9,J11,J18,J1,J2,J3,J4,J5,J6,J8,J9,K13,K15,K16,K19,K20,K2,K3,K4,K6,K8  &


#sliding windows (HTG893)
python2 ../popgenWindows.py -w 10000 -s 5000 -g HTG893.geno -o popstats_HTG893.csv -f phased -T 5 -p walpole 15_10,15_11,15_3,15_5,15_6,15_7,16_2,16_3,16_7,16_8,17_10,17_11,17_1,17_3,17_4,17_6,17_7,17_9,18_11,18_15,18_16,18_1,18_2,18_3,19_1_1,19_1_3,19_3,19_4,19_5,27_10,27_2,27_3,27_4,27_5,27_6,27_8,27_9 -p natural N1_1,N1_2,N1_3,N1_5,N1_6,N3_1,N3_2,N3_3,N4_2,N4_3 -p essex 4_11,4_12,4_13,4_16,4_18,4_1,4_2,4_8,4_9,5_10,5_15,5_19,5_2,5_4,5_7,5_8,6_10,6_2,6_3,6_5,6_6,6_7,6_9,7_10,7_12,7_14,7_2,7_5,7_7,9_10,9_11,9_1,9_4,9_5,9_6,9_7,9_9 -p illinois B10,B11,B13,B16,B19,B1,B3,B4,B7,B9,D10,D11,D12,D14,D15,D1,D2,D4,D5,D6,E10,E14,E15,E19,E2,E3,E6,E7,F10,F11,F12,F13,F1,F4,F5,F7,F9,G10,G11,G13,G15,G2,G5,G7,H10,H11,H14,H1,H2,H4,H6,H8,H9,J11,J18,J1,J2,J3,J4,J5,J6,J8,J9,K13,K15,K16,K19,K20,K2,K3,K4,K6,K8 --verbose &


#sliding windows (HTG893)
python2 ../popgenWindows.py -w 10000 -s 4000 -o popgenstats_5pops_10KB -g both3.geno -f phased -T 5 -p walpole 15_10,15_11,15_3,15_5,15_6,15_7,16_2,16_3,16_7,16_8,17_10,17_11,17_1,17_3,17_4,17_6,17_7,17_9,18_11,18_15,18_16,18_1,18_2,18_3,19_1_1,19_1_3,19_3,19_4,19_5,27_10,27_2,27_3,27_4,27_5,27_6,27_8,27_9 -p natural N/N1_1,N/N1_2,N/N1_3,N/N1_5,N/N1_6,N/N3_1,N/N3_2,N/N3_3,N/N4_2,N/N4_3 -p essex 4_11,4_12,4_13,4_16,4_18,4_1,4_2,4_8,4_9,5_10,5_15,5_19,5_2,5_4,5_7,5_8,6_10,6_2,6_3,6_5,6_6,6_7,6_9,7_10,7_12,7_14,7_2,7_5,7_7,9_10,9_11,9_1,9_4,9_5,9_6,9_7,9_9 -p illinois_admixed B10,B11,B13,B16,B19,B1,B3,B4,B7,B9,E10,E14,E15,E19,E2,E3,E6,E7,F10,F11,F12,F13,F1,F4,F5,F7,F9,G10,G11,G13,G15,G2,G5,G7,H10,H11,H14,H1,H2,H4,H6,H8,H9,J11,J18,J1,J2,J3,J4,J5,J6,J8,J9 -p illinois_western K13,K15,K16,K19,K20,K2,K3,K4,K6,K8,,D10,D11,D12,D14,D15,D1,D2,D4,D5,D6 --verbose &



####
#ABBA-BABA
#nat-walpole-essex
python2 ../ABBABABAwindows.py -g both3.geno -f phased -o abba_babba_nat_walpole_essex_10kb.csv -w 10000 -m 100 -s 10000 --pop1 nat N/N1_1,N/N1_2,N/N1_3,N/N1_5,N/N1_6,N/N3_1,N/N3_2,N/N3_3,N/N4_2,N/N4_3 --pop2 walpole 15_10,15_11,15_3,15_5,15_6,15_7,16_2,16_3,16_7,16_8,17_10,17_11,17_1,17_3,17_4,17_6,17_7,17_9,18_11,18_15,18_16,18_1,18_2,18_3,19_1_1,19_1_3,19_3,19_4,19_5,27_10,27_2,27_3,27_4,27_5,27_6,27_8,27_9 --pop3 essex 4_11,4_12,4_13,4_16,4_18,4_1,4_2,4_8,4_9,5_10,5_15,5_19,5_2,5_4,5_7,5_8,6_10,6_2,6_3,6_5,6_6,6_7,6_9,7_10,7_12,7_14,7_2,7_5,7_7,9_10,9_11,9_1,9_4,9_5,9_6,9_7,9_9 -O O hypo_sorted.bam -T 10 --minData 0.6  &


#walpole-essex-ill
python2 ../ABBABABAwindows.py -g both3.geno -f phased -o abba_babba_walpole_essex_illinois_10kb.csv -w 10000 -m 100 -s 10000 --pop1 walpole 15_10,15_11,15_3,15_5,15_6,15_7,16_2,16_3,16_7,16_8,17_10,17_11,17_1,17_3,17_4,17_6,17_7,17_9,18_11,18_15,18_16,18_1,18_2,18_3,19_1_1,19_1_3,19_3,19_4,19_5,27_10,27_2,27_3,27_4,27_5,27_6,27_8,27_9 --pop2 essex 4_11,4_12,4_13,4_16,4_18,4_1,4_2,4_8,4_9,5_10,5_15,5_19,5_2,5_4,5_7,5_8,6_10,6_2,6_3,6_5,6_6,6_7,6_9,7_10,7_12,7_14,7_2,7_5,7_7,9_10,9_11,9_1,9_4,9_5,9_6,9_7,9_9 --pop3 illinois B10,B11,B13,B16,B19,B1,B3,B4,B7,B9,D10,D11,D12,D14,D15,D1,D2,D4,D5,D6,E10,E14,E15,E19,E2,E3,E6,E7,F10,F11,F12,F13,F1,F4,F5,F7,F9,G10,G11,G13,G15,G2,G5,G7,H10,H11,H14,H1,H2,H4,H6,H8,H9,J11,J18,J1,J2,J3,J4,J5,J6,J8,J9,K13,K15,K16,K19,K20,K2,K3,K4,K6,K8 -O O hypo_sorted.bam -T 10 --minData 0.6 &

#nat-walpole-ill
python2 ../ABBABABAwindows.py -g both3.geno -f phased -o abba_babba_nat_walpole_illinois_10kb.csv -w 10000 -m 100 -s 10000 --pop1 nat N/N1_1,N/N1_2,N/N1_3,N/N1_5,N/N1_6,N/N3_1,N/N3_2,N/N3_3,N/N4_2,N/N4_3 --pop2 walpole 15_10,15_11,15_3,15_5,15_6,15_7,16_2,16_3,16_7,16_8,17_10,17_11,17_1,17_3,17_4,17_6,17_7,17_9,18_11,18_15,18_16,18_1,18_2,18_3,19_1_1,19_1_3,19_3,19_4,19_5,27_10,27_2,27_3,27_4,27_5,27_6,27_8,27_9 --pop3 illinois B10,B11,B13,B16,B19,B1,B3,B4,B7,B9,D10,D11,D12,D14,D15,D1,D2,D4,D5,D6,E10,E14,E15,E19,E2,E3,E6,E7,F10,F11,F12,F13,F1,F4,F5,F7,F9,G10,G11,G13,G15,G2,G5,G7,H10,H11,H14,H1,H2,H4,H6,H8,H9,J11,J18,J1,J2,J3,J4,J5,J6,J8,J9,K13,K15,K16,K19,K20,K2,K3,K4,K6,K8 -O O hypo_sorted.bam -T 10 --minData 0.6 &

#nat-ess-ill
python2 ../ABBABABAwindows.py -g both3.geno -f phased -o abba_babba_nat_essex_illinois_10kb.csv -w 10000 -m 100 -s 10000 --pop1 nat N/N1_1,N/N1_2,N/N1_3,N/N1_5,N/N1_6,N/N3_1,N/N3_2,N/N3_3,N/N4_2,N/N4_3 --pop2 essex 4_11,4_12,4_13,4_16,4_18,4_1,4_2,4_8,4_9,5_10,5_15,5_19,5_2,5_4,5_7,5_8,6_10,6_2,6_3,6_5,6_6,6_7,6_9,7_10,7_12,7_14,7_2,7_5,7_7,9_10,9_11,9_1,9_4,9_5,9_6,9_7,9_9 --pop3 illinois B10,B11,B13,B16,B19,B1,B3,B4,B7,B9,D10,D11,D12,D14,D15,D1,D2,D4,D5,D6,E10,E14,E15,E19,E2,E3,E6,E7,F10,F11,F12,F13,F1,F4,F5,F7,F9,G10,G11,G13,G15,G2,G5,G7,H10,H11,H14,H1,H2,H4,H6,H8,H9,J11,J18,J1,J2,J3,J4,J5,J6,J8,J9,K13,K15,K16,K19,K20,K2,K3,K4,K6,K8 -O O hypo_sorted.bam -T 10 --minData 0.6 &

#essex-ill-nat

python2 ../ABBABABAwindows.py -g both3.geno -f phased -o abba_babba_essex_illinois_nat.csv -w 10000 -m 100 -s 10000 --pop1 essex 4_11,4_12,4_13,4_16,4_18,4_1,4_2,4_8,4_9,5_10,5_15,5_19,5_2,5_4,5_7,5_8,6_10,6_2,6_3,6_5,6_6,6_7,6_9,7_10,7_12,7_14,7_2,7_5,7_7,9_10,9_11,9_1,9_4,9_5,9_6,9_7,9_9 --pop2 illinois B10,B11,B13,B16,B19,B1,B3,B4,B7,B9,D10,D11,D12,D14,D15,D1,D2,D4,D5,D6,E10,E14,E15,E19,E2,E3,E6,E7,F10,F11,F12,F13,F1,F4,F5,F7,F9,G10,G11,G13,G15,G2,G5,G7,H10,H11,H14,H1,H2,H4,H6,H8,H9,J11,J18,J1,J2,J3,J4,J5,J6,J8,J9,K13,K15,K16,K19,K20,K2,K3,K4,K6,K8 --pop3 nat N/N1_1,N/N1_2,N/N1_3,N/N1_5,N/N1_6,N/N3_1,N/N3_2,N/N3_3,N/N4_2,N/N4_3 -O O hypo_sorted.bam -T 10 --minData 0.6 &

#whats the mean?
awk -F, '{ sum += $9; n++ } END { if (n > 0) print sum / n; }' abba_babba_allsamples_max40missing.csv


python2 ../phyml_sliding_windows.py -T 10 -g phased_allsamples.geno --prefix ontario_illinois_raxml_win250_phased -w 500 --windType sites --model GTR --log ~/waterhemp/data/finaldata_all/final_vcfs/genomics_general/logfile &



make instaill DESTDIR=/lib64
