#####Julia Kreiner, June 2018
###Run LDhat seperately for each contig


#for i in $(ls x*)  
#do

while read sample
do

mkdir $sample
cd $sample
~/software/LDhat/interval -seq ../${sample}.ldhat.sites -loc ../${sample}.ldhat.locs -lk ../lk_n120_t0.001 -fileprefix ${sample} -its 5000000 -bpen 5 -samp 2000 &
cd ..

done < x19

#x17

