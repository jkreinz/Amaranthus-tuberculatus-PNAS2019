BEGIN {OFS = "\t"}
{ printf $1"\t"$2"\t"$4"\t"$5"\t"
        for (i=10; i<=NF; ++i){
                if (toupper($i) == "0|0" )
                        printf $4"|"$4 "\t";
		if (toupper($i) == "0|1" && $5 ~ /,/){
			split ($5,a,","); printf $4"|"a[1] "\t"}
		if (toupper($i) == "0|1" && $5 !~ /,/){
			printf $4"|"$5 "\t"}
		if (toupper($i) == "1|0" && $5 ~ /,/){
			split ($5,a,","); printf a[1]"|"$4 "\t"}
		if (toupper($i) == "1|0" && $5 !~ /,/){
                        printf $5"|"$4 "\t"}
		if (toupper($i) == "1|1" && $5 ~ /,/){
			split ($5,a,","); printf a[1]"|"a[1] "\t"}
		if (toupper($i) == "1|1" && $5 !~ /,/){
			printf $5"|"$5 "\t"}
		if (toupper($i) == "1|2" ){
                        split ($5,a,","); printf a[1]"|"a[2] "\t"}
                if (toupper($i) == "2|1" ){
                        split ($5,a,","); printf a[2]"|"a[1] "\t"}
                if (toupper($i) == "0|2" ){
                        split ($5,a,","); printf $4"|"a[2] "\t"}
                if (toupper($i) == "2|0" ){
                        split ($5,a,","); printf a[2]"|"$4 "\t"}
                if (toupper($i) == "2|2" ){
                        split ($5,a,","); printf a[2]"|"a[2] "\t"}
				}
	printf "\n"
}
