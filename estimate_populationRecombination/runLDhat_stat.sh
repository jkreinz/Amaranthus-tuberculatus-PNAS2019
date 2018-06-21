for sample in HTG_2116 HTG_2165 HTG_2168 HTG_2182 HTG_2105
#do

#while read sample
do

#mkdir $sample
cd $sample
~/software/LDhat/interval -seq ../${sample}.ldhat.sites -loc ../${sample}.ldhat.locs -lk ../lk_n120_t0.001 -fileprefix ${sample} -its 5000000 -bpen 5 -samp 2000 &
~/software/LDhat/stat -input rates.txt -locs ../${sample}.ldhat.locs
mv res.txt ${sample}_res.txt
mv ${sample}_res.txt /ohta/julia.kreiner/waterhemp/data/finaldata_all/final_bams/pileups/hapmix/other_chroms/
cd ..

done

#wait

#done
