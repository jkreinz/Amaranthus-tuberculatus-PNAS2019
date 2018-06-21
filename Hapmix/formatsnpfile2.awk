BEGIN {OFS = "\t"}
{       zcount = 0
        for (i=10; i<=NF; ++i)
		if (toupper($i) == "1") ++zcount
	if (zcount > 0) {
	print $0;
	}
}

	
