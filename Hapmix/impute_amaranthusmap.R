recomb<-read.table("recomb_bysite_60samples_filteredsnps.txt")

recomb$conversion<-recomb$V3 * (100/(4*500000))
recomb$cumulative<-cumsum(recomb$conversion)


library(stats)
#install.packages("data.table")
library(data.table)
#install.packages("dplyr")
library(dplyr)


#map<-fread("/Users/WrightUofT/Dropbox/Capsella_genetic_map_v1.0.txt")
map<-recomb[,c(1:2,5)]
colnames(map)<-c("scaf","genpos","physpos")

essex<-fread("missou01_5")
nat<-fread("nat01_5")
walpole<-fread("illinois012_5")

phased<-fread("sites.txt")

colnames(phased)<-c("CHROM","POS")
colnames(essex)<-c("CHROM","POS","REF","ALT")
colnames(nat)<-c("CHROM","POS","REF","ALT")

pos<-read.table("illinois_012_matched_wh_missing.012.pos")
names(pos)<-c("CHROM","POS")
walpole<-inner_join(walpole,pos,by=c("CHROM","POS"))

essexg<-essexg[,1:2]
natg<-natg[,1:2]
walpoleg<-walpoleg[,1:2]

colnames(walpoleg)<-c("CHROM","POS")
colnames(essexg)<-c("CHROM","POS")
colnames(natg)<-c("CHROM","POS")

install.packages("sqldf")
require(sqldf)
sqldf('SELECT * FROM essex EXCEPT SELECT * FROM essexg')

require(dplyr) 
anti_join(essexg,essex)

#walpole_sweep<-fread("walpole_AFFsweepfinder.txt")
#essex_sweep<-fread("essex_AFFsweepfinder.txt")
#illinois_sweep<-fread("illinois_AFFsweepfinder.txt")



options(digits=10)

interp1<-splinefun(map$genpos, map$physpos, method = "monoH.FC")

nat$genpos<-interp1(x = nat$POS)
essex$genpos<-interp1(x = essex$POS)
walpole$genpos<-interp1(x = walpole$POS)

phased$genpos<-interp1(x = phased$POS)

#walpole_sweep$genpos<-interp1(x = walpole_sweep$position)
#essex_sweep$genpos<-interp1(x = essex_sweep$position)
#illinois_sweep$genpos<-interp1(x = illinois_sweep$position)


is.unsorted(essex$genpos)
is.unsorted(nat$genpos)
is.unsorted(walpole$genpos)

is.unsorted(phased$genpos)

#is.unsorted(walpole_sweep$genpos)
#row.names(walpole_sweep)<-NULL
#see<-(!diff(walpole_sweep$genpos) < 0)
#see2<-which(see==FALSE)
#see2
#walpole_sweep<-walpole_sweep[-c(4503,4749,12847,60812,60813,60814),]
#walpole_sweep<-walpole_sweep[-c(60808),]

#is.unsorted(essex_sweep$genpos)
#row.names(essex_sweep)<-NULL
#see<-(!diff(essex_sweep$genpos) < 0)
#see2<-which(see==FALSE)
#see2
#essex_sweep<-essex_sweep[-c(4503,4749,12847,60812,60813,60814),]
#essex_sweep<-essex_sweep[-c(60808),]
#
#is.unsorted(illinois_sweep$genpos)
#row.names(illinois_sweep)<-NULL
#see<-(!diff(illinois_sweep$genpos) < 0)
#see2<-which(see==FALSE)
#see2
#illinois_sweep<-illinois_sweep[-c(2994,10290,57196,57197,57285, 57286),]



row.names(phased)<-NULL
see<-(!diff(phased$genpos) < 0)
see2<-which(see==FALSE)
see2
test<-phased[c(5021,5022,5328,14539,73969,73970,74106,74107,74108),]
test<-phased[c(74099),]

row.names(nat)<-NULL
see<-(!diff(nat$genpos) < 0)
see2<-which(see==FALSE)
see2
nat<-nat[-c(15370),]

row.names(walpole)<-NULL
see<-(!diff(walpole$genpos) < 0)
see2<-which(see==FALSE)
see2
walpole<-walpole[-c( 14248),]

essex$snp<-paste("snp_",essex$POS,sep="")
nat$snp<-paste("snp_",nat$POS,sep="")
walpole$snp<-paste("snp_",walpole$POS,sep="")
phased$snp<-paste("snp_",phased$POS,sep="")

essex$genpos<-essex$genpos/100
nat$genpos<-nat$genpos/100
walpole$genpos<-walpole$genpos/100
phased$genpos<-phased$genpos/100

essex_final<-essex[,c(6,1,5,2,3,4)]
nat_final<-nat[,c(6,1,5,2,3,4)]
walpole_final<-walpole[,c(6,1,5,2,3,4)]
phased_final<-phased[,c(1,4,3,2)]


write.table(essex_final, file = "missou_snpformat.22", sep="\t",quote=F, col.names = F, row.names = F)
write.table(nat_final, file = "nat_snpformat.22", sep="\t",quote=F, col.names = F, row.names = F)
write.table(walpole_final, file = "illinois_snpformat.22", sep="\t",quote=F, col.names = F, row.names = F)
write.table(phased_final, file = "phased_snps.map", sep="\t",quote=F, col.names = F, row.names = F)

walpole_finalsweep<-walpole_sweep[,c(1,5)]
names(walpole_finalsweep)<-c("position","rate")

essex_finalsweep<-essex_sweep[,c(1,5)]
names(essex_finalsweep)<-c("position","rate")

illinois_finalsweep<-illinois_sweep[,c(1,5)]
names(illinois_finalsweep)<-c("position","rate")

write.table(walpole_finalsweep, file = "walpole_sweep.recomb", sep="\t",quote=F, col.names = T, row.names = F)
write.table(illinois_finalsweep, file = "illinois_sweep.recomb", sep="\t",quote=F, col.names = T, row.names = F)
write.table(essex_finalsweep, file = "essex_sweep.recomb", sep="\t",quote=F, col.names = T, row.names = F)
