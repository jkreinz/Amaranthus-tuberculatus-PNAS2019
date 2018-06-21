library(data.table)
cds<-fread("~/cds_bysite",data.table = F)
names(cds)<-c("chrom","pos")

library(dplyr)
library(magrittr)

cds_windowed<- cds %>% mutate(win=floor(pos/10000)) %>% group_by(chrom,win) %>% summarise(cds_density=(n()/10000))
cds_windowed$win2<-cds_windowed$win+1
cds_windowed$end<-cds_windowed$win2*10000
cds_windowed$start<-cds_windowed$end-9999

cds_density<-subset(cds_windowed, select=c('chrom','start','end','cds_density'))
cds_density$start <-format(cds_density$start, scientific = FALSE) 
cds_density$end <-format(cds_density$end, scientific = FALSE) 

cds_893<-cds_windowed[cds_windowed$chrom=="HTG_893",]

write.csv(cds_density,file="cds_density_10kb.txt",row.names = F,quote = F)

########
final<-fread("ill_nat_density_fd.txt")
final$V14[final$V14<0]<-0
final$V14[final$V14>1]<-NA
final<-final[complete.cases(final), ]
ep<-final[final$V1=="HTG_893"]


lm1<-lm(final$V14~final$V4)
summary(lm1)

plot(final$V14~final$V4,pch=20, ylab="Admixture Proportion", xlab="CDS Density/10KB", main= "Admixture in Illinois from NatPops" )
abline(a=lm1$coefficients[1],lm1$coefficients[2])

qqnorm(final$V14)
qqnorm(final$V4)

#walpole-essex
final<-fread("walpole_essex_density_fd.txt")
final$V14[final$V14<0]<-0
final$V14[final$V14>1]<-NA
final<-final[complete.cases(final), ]

lm1<-lm(final$V14~final$V4)
summary(lm1)

plot(final$V14~final$V4,pch=20, ylab="Admixture Proportion", xlab="CDS Density/10KB", main= "Admixture in Walpole from Essex" )
abline(a=lm1$coefficients[1],lm1$coefficients[2])

qqnorm(final$V14)
qqnorm(final$V4)

