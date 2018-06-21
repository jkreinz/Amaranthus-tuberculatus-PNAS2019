REGION=HTG_893:401724-412731
sample=$1
folder=$2

cd ${sample}_denovoEPSPS/assembly/
mv scaffolds.fasta ${sample}_dnvoasbl.fasta

#remove small sequences
perl ../../removesmalls.pl 250 ${sample}_dnvoasbl.fasta > ${sample}_dnvoasbl-l200.fasta
#remove low coverage sequences
awk 'BEGIN { RS = ">."; FS = "\n";OFS="\n" } split($1,f,"_") {if(f[6]>2) {print $0}}' ${sample}_dnvoasbl-l200.fasta > ${sample}_dnvoasbl-l200_mincov2.fasta

mv ${sample}_dnvoasbl-l200_mincov2.fasta ../../denovo_EPSPS/
cd ../../
