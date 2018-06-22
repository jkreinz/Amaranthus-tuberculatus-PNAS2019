# Amaranthus population genomics

This repository contains sets of pipelines for various population genomic analyses of a diploid, dioecious plant with a reference assembly:

1. [Alignment and bam processing](https://github.com/jkreinz/Amaranthus-population-genomics/tree/master/aligning_bamprocessing/) - Preprocess FASTQ's, run BWAmem, process bams with sambamba, picard to GATK
2. [SNP calling and filtering](https://github.com/jkreinz/Amaranthus-population-genomics/tree/master/snp_calling_filtering/) - Call SNPs with freebayes and filter
3. [PLINK pipelines and related analyses](https://github.com/jkreinz/Amaranthus-population-genomics/tree/master/PLINK%20universe/) - Running PLINK, treemix, faststructure, & beagle
4. [Getting basic summary stats (Dxy, Fst, Pi, ABBA-BABA)](https://github.com/jkreinz/Amaranthus-population-genomics/tree/master/genomics_general_ABBABABA_summarystats/) - Use genomicsgeneral scripts from Simon Martin
5. [Estimating recombination rates](https://github.com/jkreinz/Amaranthus-population-genomics/tree/master/estimate_populationRecombination/) - Use LDhat and Hapcut to estimate Rho
5. [Detecting selective sweeps](https://github.com/jkreinz/Amaranthus-population-genomics/tree/master/sweep_analyses/) - selscan, H12, & sweepscan2
6. [Investigating introgression](https://github.com/jkreinz/Amaranthus-population-genomics/tree/master/Hapmix/) - Run hapmix on phased samples
7. [Investigating copy number](https://github.com/jkreinz/Amaranthus-population-genomics/tree/master/coverage_copynum_investigations/) - Custom R scripts for plotting coverage per individual and by region to investigate copy number heterogeneity
8. [De novo assembly](https://github.com/jkreinz/Amaranthus-population-genomics/tree/master/denovo_assembly/) - Using spades



