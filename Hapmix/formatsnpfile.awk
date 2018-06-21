BEGIN {OFS = "\t"}
{       printf $2"\t"
        for (i=10; i<=NF; ++i) {
                split($i,f,"|")
		printf f[1] "\t" f[2] "\t" 
			}
	printf "\n"
}

	
