library(devtools)
install_github("jhavsmith/startmrca")
library(startmrca)
help(run.startmrca)

run.startmrca(vcf.file      = "893_phased.vcf.gz",
              rec.file      = NULL, 
              sample.ids    = "Dropbox/EPSPSselected.txt", 
              refsample.ids = "Dropbox/EPSPSreference.txt",
              mut.rate      = 7e-9, 
              rec.rate      = 0.02,
              nsel          = 69,
              nanc          = 96,
              chain.length  = 20,
              nanc.post     = 10,
              pos           = 400958,
              sel.allele    = 1)


run.startmrca(vcf.file      = "893_phased_walpole_aroundsite_bi.recode.vcf.gz",
              rec.file      = NULL, 
              sample.ids    = "Dropbox/walpole_selected.txt", 
              refsample.ids = "Dropbox/walpole_reference.txt",
              mut.rate      = 7e-9, 
              rec.rate      = 0.02,
              nsel          = 34,
              nanc          = 50,
              chain.length  = 20,
              nanc.post     = 10,
              pos           = 400958,
              sel.allele    = 1)


run.startmrca(vcf.file      = "893_walpole_unphased.recode.vcf.gz",
              rec.file      = NULL, 
              sample.ids    = "Dropbox/walpole_selected.txt", 
              refsample.ids = "Dropbox/walpole_reference.txt",
              mut.rate      = 7e-9, 
              rec.rate      = 0.02,
              nsel          = 34,
              nanc          = 50,
              chain.length  = 20,
              nanc.post     = 10,
              pos           = 400958,
              sel.allele    = 1)

