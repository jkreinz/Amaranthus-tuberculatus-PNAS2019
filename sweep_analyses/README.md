#Detect selective sweeps on focal regions based on haplotype number, homozygosity, and signals from the SFS

1. runselscan.sh: Use the program [selscan](https://github.com/szpiech/selscan) to detect selection based on haplotype structure (>5 different summarystats available from iHH, XP-CLR, etc.)
2. H12 folder: Format input file for running [H12 stat](https://github.com/ngarud/SelectionHapStats/) from beagle phased gvcf 
3. plot haplotype trees.R: Plot newick format trees from clusterw output of phased VCF --> MAF
4. sweepfinder2 folder: format input file from vcf to sweepfinder input using format_sweepfinder.sh pipeline
