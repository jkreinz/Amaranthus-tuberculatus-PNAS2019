BEGIN { FS=OFS="\t" } FNR == 1 {{for(i=3;i<=NF;++i)printf $i "\t"} printf "\n"}; FNR == 1 {next};
{
    for (i=3; i<=NF; i++) {
        split($i,f,":")
	if (f[1] == "0/1" || f[1] == "1/1" || f[1] == "1/0" ) {
		printf "1" "\t"}
	else {
		printf "0" "\t"}
}
printf "\n"
}



