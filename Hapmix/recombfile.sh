output1=`tail -n +1 essex_snpformat.22 | wc -l`
echo :sites:$output1 > essex.recomb
output2=`tail -n +1 essex_snpformat.22 | awk '{print $4}' | tr -s '\n' ' '`
output3=`tail -n +1 essex_snpformat.22 | awk '{print $3*100}' | tr -s '\n' ' '`
echo -e $output2 >> essex.recomb
echo -e $output3 >> essex.recomb
