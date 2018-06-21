BEGIN {OFS = "\t"}
{       printf $2",";
        for (i=10; i<=NF; ++i) {
		split($i,f,"|")
		split($5,a,",")
                if (toupper(f[1]) == 0){
                        printf $4",";
                      }
                else if (toupper(f[1]) == 1){
                        printf a[1]",";
                      }
		else if (toupper(f[1]) == 2){
			printf a[2]",";
                      }
		if (toupper(f[2]) == 0){
                        printf $4",";
                      }
                else if (toupper(f[2]) == 1){
                        printf a[1]",";
                      }
                else if (toupper(f[2]) == 2){
                        printf a[2]",";
                      }
	}
	printf "\n";
}
