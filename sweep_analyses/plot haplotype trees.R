#012 to ape tree

install.packages("ape")
library(ape)
library(data.table)

install.packages("phytools")
require(phytools)

Res<-fread("012inds_res.txt",data.table=F,header=F)
resistance1<-as.vector(Res$V1)

tree<-read.tree("EPSPS1.tree")
tips<-as.data.frame(tree$tip.label)
plot(tree, tip.color=resistance1,edge.width=2,cex=.7,
     label.offset=.005,underscore=T,align.tip.label=T)
add.scale.bar(length=0.05)


tree<-read.tree("EPSPS2.tree")
plot(tree)
Res<-fread("EPSPShap2_colors.txt",data.table=F,header=F)
resistance2<-as.vector(Res$V1)

plot(tree, tip.color=resistance2,edge.width=2,cex=.7,
     label.offset=.005,underscore=T,align.tip.label=T)
add.scale.bar(length=0.05)


library(ape)
library(data.table)
tree<-read.tree("EPSPSbothhaps.tree")
tips<-as.data.frame(tree$tip.label)
plot(tree)
Res<-fread("EPSPS_bothhaps_cols.txt",data.table=F,header=F)
resistance3<-as.vector(Res$V1)

plot(tree, tip.color=resistance3,edge.width=1,cex=.6,
     label.offset=.005,underscore=T,align.tip.label=T,
     direction="upwards")

add.scale.bar(length=0.05)


library(phytools)

tree<-read.tree("walpoleEPSPS_bothhaps.tree")
plot(tree)
tips<-as.data.frame(tree$tip.label)
inds<-read.table("Dropbox/walpole EPSPS cols.txt")
row.names(inds)<-inds$V1
copy<-inds$V2
names(copy)<-inds$V1
resistance<-inds$V3
names(resistance)<-inds$V1
#plotTree.barplot(tree,copy,
#                 args.barplot=list(col=sapply(resistance, function(resistance) if(resistance=="R") "red" else "blue")))

plotTree.barplot(tree,copy,found=.5,list(xlim=c(0,30)))



tree<-read.tree("essexEPSPS_bothhaps.tree")
plot(tree)
tips<-as.data.frame(tree$tip.label)
inds<-read.table("Dropbox/essex EPSPS cols.txt")
row.names(inds)<-inds$V1
copy<-inds$V2
names(copy)<-inds$V1
resistance<-inds$V3
names(resistance)<-inds$V1
#plotTree.barplot(tree,copy,
#                 args.barplot=list(col=sapply(resistance, function(resistance) if(resistance=="R") "red" else "blue")))

plotTree.barplot(tree,copy,found=.5,list(xlim=c(0,30)))


tree<-read.tree("illinoisEPSPS_bothhaps.tree")
plot(tree)
tips<-as.data.frame(tree$tip.label)
inds<-read.table("Dropbox/illinois EPSPS cols.txt")
row.names(inds)<-inds$V1
copy<-inds$V2
names(copy)<-inds$V1
resistance<-inds$V3
names(resistance)<-inds$V1
#plotTree.barplot(tree,copy,
#                 args.barplot=list(col=sapply(resistance, function(resistance) if(resistance=="R") "red" else "blue")))

plotTree.barplot(tree,copy,found=.5,list(xlim=c(0,30)))


tree<-read.tree("EPSPSbothhaps.tree")
plot(tree)
tips<-as.data.frame(tree$tip.label)
inds<-read.table("Dropbox/allpops EPSPS cols.txt")
row.names(inds)<-inds$V1
copy<-inds$V2
names(copy)<-inds$V1
#resistance<-inds$V3
#names(resistance)<-inds$V1
#plotTree.barplot(tree,copy,
#                 args.barplot=list(col=sapply(resistance, function(resistance) if(resistance=="R") "red" else "blue")))

plotTree.barplot(tree,copy,found=.5,list(fsize=0.3,xlab="EPSPS copy number"),list(xlim=c(0,30)))


#try with denovo haplotypes

tree<-read.tree("8000seqs_realgn_trim.tree")
plot(tree)
tips<-as.data.frame(tree$tip.label)

inds<-read.table("8000seqs_cov.txt")
row.names(inds)<-inds$V1
copy<-inds$V2
names(copy)<-inds$V1

inds$V1<-as.character(inds$V1)
tree$tip.label<-inds$V1

copy<-as.data.frame(copy)

plotTree.barplot(tree,copy,found=.5,list(fsize=0.6,lab="EPSPS copy number"))

########
#how does het relate to copy?

hetz<-read.csv("Dropbox/het by copy.csv")
library(ggplot2)
ggplot(data=hetz,aes(F,Copy)) +
  geom_point() +
  geom_smooth(method="loess") +
  #ylim(0,30) +
  theme_bw()


#########################
#haplotype networks in R
#########################
install.packages("pegas")
library(pegas)

input <- "walpole_EPSPS_hap1_realigned.fasta"
d <- ape::read.dna(input, format='fasta')
e <- dist.dna(d)
h <- pegas::haplotype(d)
h <- sort(h, what = "label")
(net <- pegas::haploNet(h))
ind.hap<-with(
  stack(setNames(attr(h, "index"), rownames(h))),
  table(hap=ind, pop=rownames(d)[values])
)

require(phytools)
plot(net, size=attr(net, "freq"), show.mutation=0, scale.ratio=.01,cex = 0.8, pie=ind.hap)
legend(-30, 13, colnames(ind.hap), col=rainbow(ncol(ind.hap)), pch=19, ncol=2,title="Walpole Hap1")
#text(-1,1, "Walpole Hap1")


input <- "walpole_EPSPS_hap2_realigned.fasta"
d <- ape::read.dna(input, format='fasta')
e <- dist.dna(d)
h <- pegas::haplotype(d)
h <- sort(h, what = "label")
(net <- pegas::haploNet(h))
ind.hap<-with(
  stack(setNames(attr(h, "index"), rownames(h))),
  table(hap=ind, pop=rownames(d)[values])
)

plot(net, size=attr(net, "freq"), show.mutation=0, scale.ratio=.01,cex = 0.8, pie=ind.hap)
legend(-25, 13, colnames(ind.hap), col=rainbow(ncol(ind.hap)), pch=19, ncol=2,title="Walpole Hap2")
#text(-1,1, "Walpole Hap1")




input <- "essex_EPSPS_hap1_realigned.fasta"
d <- ape::read.dna(input, format='fasta')
e <- dist.dna(d)
h <- pegas::haplotype(d)
h <- sort(h, what = "label")
(net <- pegas::haploNet(h))
ind.hap<-with(
  stack(setNames(attr(h, "index"), rownames(h))),
  table(hap=ind, pop=rownames(d)[values])
)

plot(net, size=attr(net, "freq"), show.mutation=0, scale.ratio=.01,cex = 0.8, pie=ind.hap)
legend(-15, 5, colnames(ind.hap), col=rainbow(ncol(ind.hap)), pch=19, ncol=2, title="Essex Hap1")
#text(-1,1, "Walpole Hap1")




input <- "essex_EPSPS_hap2_realigned.fasta"
d <- ape::read.dna(input, format='fasta')
e <- dist.dna(d)
h <- pegas::haplotype(d)
h <- sort(h, what = "label")
(net <- pegas::haploNet(h))
ind.hap<-with(
  stack(setNames(attr(h, "index"), rownames(h))),
  table(hap=ind, pop=rownames(d)[values])
)

plot(net, size=attr(net, "freq"), show.mutation=0, scale.ratio=.01,cex = 0.8, pie=ind.hap)
legend(-18, 2, colnames(ind.hap), col=rainbow(ncol(ind.hap)), pch=19, ncol=2, title="Essex Hap2")
#text(-1,1, "Walpole Hap1")



input <- "illinois_EPSPS_hap1_realigned.fasta"
d <- ape::read.dna(input, format='fasta')
e <- dist.dna(d)
h <- pegas::haplotype(d)
h <- sort(h, what = "label")
(net <- pegas::haploNet(h))
ind.hap<-with(
  stack(setNames(attr(h, "index"), rownames(h))),
  table(hap=ind, pop=rownames(d)[values])
)

plot(net, size=attr(net, "freq"), show.mutation=0, scale.ratio=.01,cex = 0.8, pie=ind.hap)
legend(-22, 20, colnames(ind.hap), col=rainbow(ncol(ind.hap)), pch=19, ncol=3, title="Illinois Hap1")
#text(-1,1, "Walpole Hap1")



input <- "illinois_EPSPS_hap2_realigned.fasta"
d <- ape::read.dna(input, format='fasta')
e <- dist.dna(d)
h <- pegas::haplotype(d)
h <- sort(h, what = "label")
(net <- pegas::haploNet(h))
ind.hap<-with(
  stack(setNames(attr(h, "index"), rownames(h))),
  table(hap=ind, pop=rownames(d)[values])
)

plot(net, size=attr(net, "freq"), show.mutation=0, scale.ratio=.01,cex = 0.8, pie=ind.hap)
legend(-22, 20, colnames(ind.hap), col=rainbow(ncol(ind.hap)), pch=19, ncol=3, title="Illinois Hap2")
#text(-1,1, "Walpole Hap1")

############
#all regions
############

input <- "EPSPS_hap1_realigned.fasta"
d <- ape::read.dna(input, format='fasta')
e <- dist.dna(d)
h <- pegas::haplotype(d)
h <- sort(h, what = "label")
(net <- pegas::haploNet(h))
ind.hap<-with(
  stack(setNames(attr(h, "index"), rownames(h))),
  table(hap=ind, pop=rownames(d)[values])
)

plot(net, size=attr(net, "freq"), show.mutation=0, scale.ratio=.01,cex = 0.8, pie=ind.hap,labels=F)
legend(-54, -1, colnames(ind.hap), col=rainbow(ncol(ind.hap)), pch=19, ncol=10, title="All Regions Haplotype 1",cex=.65)





input <- "EPSPS_hap2_realigned.fasta"
d <- ape::read.dna(input, format='fasta')
e <- dist.dna(d)
h <- pegas::haplotype(d)
h <- sort(h, what = "label")
(net <- pegas::haploNet(h))
ind.hap<-with(
  stack(setNames(attr(h, "index"), rownames(h))),
  table(hap=ind, pop=rownames(d)[values])
)

plot(net, size=attr(net, "freq"), show.mutation=0, scale.ratio=.01,cex = 0.8, pie=ind.hap,labels=F)
legend(-54, -1, colnames(ind.hap), col=rainbow(ncol(ind.hap)), pch=19, ncol=10, title="All Regions Haplotype 2",cex=.65)
