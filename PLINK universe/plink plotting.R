cov<-fread("meandepthpersite",header=F)
hist(cov$V1, xlim=c(0,100),breaks=50000, main="Ontario",xlab="Mean depth per site")
abline(v=25,lty=5)

#plot relatedness from plink
library(data.table)
relatedness<-fread("plink_sorted.genome",header=F)
library("wesanderson")
library(ggplot2)
pal <- wes_palette("Zissou", 100, type = "continuous")

ggplot(relatedness,aes(V1,V3)) + 
  geom_tile(aes(fill=V10)) + 
  scale_fill_continuous(colours=pal,name="Prop. IBD\n") +
  labs(x="",y="") +
  theme_bw() + 
  theme(axis.text.x=element_text(size=8, angle=90),
                     axis.text.y=element_text(size=8),
                     legend.text=element_text(size=9),
                     legend.title=element_text(size=10)) 


#plot PCA eigenvalues from plink
library(data.table)
eigen<-fread("plink.eigenvec",header = F)
pops<-fread("popcode.txt",header=F)

#eigen$V1 <- gsub("\\_.*","", eigen$V1)
eigen$popcode<-pops$V1
eigen<-eigen[-13,]
#plot(eigen[,1:6])

lm1<-lm(eigen$V3~owgps$V3)
summary(lm1)
plot(eigen$V3~owgps$V3)

library(RColorBrewer)
brewer<-brewer.pal(14, "Dark2")
mycolors = c(brewer.pal(name="Dark2", n = 8), brewer.pal(name="Paired", n = 6))
mycolors2 <- wes_palette("Darjeeling1",8,type="continuous")
mycolors3 <- wes_palette("Darjeeling1")

library(wesanderson)
eigen$popcode  = factor(eigen$popcode, levels=c("Essex","Walpole_Island","Illinois","Missouri","Natural"))
eigen$popcode  = factor(eigen$popcode, levels=c("B","D","E","F","G","K","J","H"))


ggplot(eigen, aes(V3,V4,colour=popcode)) +
  geom_point(size=4,alpha=.8) +
  xlim(.1,-.2) +
  scale_colour_manual(values=mycolors3) +
  labs(x="PCA1",y="PCA2") +
  theme_classic()

0.969083918284246-0.956412673912299=0.01267124
0.975065347200925-0.969083918284246=  0.005981429
0.97939974066-0.9750653472 =  0.004334393
0.981498716579952-0.97939974066 = 0.002098976

ggplot(eigen, aes(V3,V5,colour=popcode)) +
  geom_point(size=4,alpha=.8) +
  scale_colour_manual(values=mycolors) +
  labs(x="PCA1",y="PCA3") +
  theme_classic()

ggplot(eigen, aes(V3,V6,colour=popcode)) +
  geom_point(size=4,alpha=.8) +
  scale_colour_manual(values=mycolors) +
  labs(x="PCA1",y="PCA4") +
  theme_classic()

ggplot(eigen, aes(V4,V5,colour=popcode)) +
  geom_point(size=4,alpha=.8) +
  scale_colour_manual(values=mycolors) +
  labs(x="PCA2",y="PCA3") +
  theme_classic()

ggplot(eigen, aes(V4,V6,colour=popcode)) +
  geom_point(size=4,alpha=.8) +
  scale_colour_manual(values=mycolors) +
  labs(x="PCA2",y="PCA4") +
  theme_classic()

ggplot(eigen, aes(V5,V6,colour=popcode)) +
  geom_point(size=4,alpha=.8) +
  scale_colour_manual(values=mycolors) +
  labs(x="PCA3",y="PCA4") +
  theme_classic()


#plot Fst from plink

library(data.table)
library(dplyr)
fst<-fread("plink.fst",header = T,stringsAsFactors = F,data.table = F)
fst$FST <- ifelse(fst$FST < 0, 0, fst$FST)
fst2<-fst[complete.cases(fst),]
windowedfst<- fst2 %>% mutate(WIN=floor(POS/10000)) %>% group_by(CHR,WIN) %>% summarise(meanFst=mean(FST),medianFst=median(FST),startpos=min(POS),endpos=max(POS))
windowedfst$order<-1:nrow(windowedfst)

library(wesanderson)
library(ggridges)
library(ggplot2)
ggplot(data=windowedfst,aes(x=order, y=meanFst),group=CHR) +
  geom_point(pch=20, cex=.6, aes(color=CHR)) +
  scale_colour_cyclical(values=wes_palette("Darjeeling")) +
  geom_smooth(method="loess",span=.01,colour="gray40") +
  labs(x="10KB windows, coloured by contig ", y="Mean Fst between Essex Ont & Walpole/Nat Ont") +
  theme_bw() + theme(legend.position="none",
                     axis.text.x=element_blank(),
                     axis.ticks.x=element_blank())

mean(na.omit(fst$FST))

#calculate PBS

fstb<-fread("plink.k3b.fst",header = T,stringsAsFactors = F,data.table = F)
fstb$FST <- ifelse(fstb$FST < 0, 0, fstb$FST)
fstb<-fstb[complete.cases(fstb),]

fstc<-fread("plink.k3c.fst",header = T,stringsAsFactors = F,data.table = F)
fstc$FST <- ifelse(fstc$FST < 0, 0, fstc$FST)
fstc<-fstc[complete.cases(fstc),]

fstd<-fread("plink.k3d.fst",header = T,stringsAsFactors = F,data.table = F)
fstd$FST <- ifelse(fstd$FST < 0, 0, fstd$FST)
fstd<-fstd[complete.cases(fstd),]

library(dplyr)
fstb2<-inner_join(fstb,fstc, by=c("CHR","POS"))
fstb3<-inner_join(fstb2,fstd, by=c("CHR","POS"))

fstc2<-inner_join(fstc,fstb, by=c("CHR","POS"))
fstc3<-inner_join(fstc2,fstd, by=c("CHR","POS"))

fstd2<-inner_join(fstd,fstb, by=c("CHR","POS"))
fstd3<-inner_join(fstd2,fstc, by=c("CHR","POS"))

#illinois PBS
fstd3$PBS <-( (-log(1-fstb3$FST)) + (-log(1-fstc3$FST)) - (-log(1-fstd3$FST)) ) / 2
fstd3$PBS <- ifelse(fstd3$PBS < 0, 0, fstd3$PBS)

windowedPBS<- fstd3 %>% mutate(WIN=floor(POS/10000)) %>% group_by(CHR,WIN) %>% summarise(meanPBS=mean(PBS),medianPBS=median(PBS),startpos=min(POS),endpos=max(POS))
windowedPBS$order<-1:nrow(windowedPBS)

library(wesanderson)
library(ggridges)
library(ggplot2)
ggplot(data=windowedPBS,aes(x=order, y=meanPBS),group=CHR) +
  geom_point(pch=20, cex=.6, aes(color=CHR)) +
  scale_colour_cyclical(values=wes_palette("Darjeeling")) +
  geom_smooth(method="loess",span=.01,colour="gray40") +
  labs(x="10KB windows, coloured by contig ", y="Mean Illinois PBS") +
  theme_bw() + theme(legend.position="none",
                     axis.text.x=element_blank(),
                     axis.ticks.x=element_blank())

#walpole PBS
fstc3$PBS <-( (-log(1-fstc3$FST)) + (-log(1-fstd3$FST)) - (-log(1-fstb3$FST)) ) / 2
fstc3$PBS <- ifelse(fstc3$PBS < 0, 0, fstc3$PBS)

windowedPBS<- fstc3 %>% mutate(WIN=floor(POS/10000)) %>% group_by(CHR,WIN) %>% summarise(meanPBS=mean(PBS),medianPBS=median(PBS),startpos=min(POS),endpos=max(POS))
windowedPBS$order<-1:nrow(windowedPBS)

library(wesanderson)
library(ggridges)
library(ggplot2)
ggplot(data=windowedPBS,aes(x=order, y=meanPBS),group=CHR) +
  geom_point(pch=20, cex=.6, aes(color=CHR)) +
  ylim(0,.40) +
  scale_colour_cyclical(values=wes_palette("Darjeeling")) +
  geom_smooth(method="loess",span=.01,colour="gray40") +
  labs(x="10KB windows, coloured by contig ", y="Mean Walpole/Nat. Ontario PBS") +
  theme_bw() + theme(legend.position="none",
                     axis.text.x=element_blank(),
                     axis.ticks.x=element_blank())


#plot LD

# import the data
library(data.table)
ld <- fread("illinois_PPO.ld",header=F)
names(ld)<-c("CHROM","FIRST","SECOND","N","LD")

#names(ld)<-c("CHR","POS1","POS2","NIND","R")

# plot the average correlation for each snp distance
ld$dist<-ld$SECOND-ld$FIRST
some<-ld[ld$dist<400000,]  

#calculate distance from PPO mutation to start and end of ALS
#5817669-5566090 = 251579
#5819684-5566090 = 253594

als<-ld[ld$dist>245000,]  
als2<-als[als$dist<260000,]  

als<-ld[ld$dist>50000,]  
als2<-als[als$dist<360000,]  


als2<-ld[ld$dist<30000,]  


#hist(als2$LD,breaks=100,
#    xlab="LD",main="LD from PPO TSR mutation to ALS gene")
#median(na.omit(als2$LD))


Trp574<-als2[als2$SECOND==5817724,]  
Ser653<-als2[als2$SECOND==5817961,]  

library(ggplot2)

ggplot(als2,aes(x=dist, y = LD)) +
  geom_point(alpha=.2) +
  geom_point(alpha=.2) +
  #geom_point(data=Trp574, colour="#c48415",cex=2.5) +
  #geom_point(data=Ser653, colour="#c48415",cex=2.5) +
  #geom_vline(xintercept=253594,lty="dashed") +
  #geom_vline(xintercept=251579,lty="dashed") +
  theme_bw() +
  #geom_smooth(method="loess",span=.08,color="#ad3e52") +
  labs(x="Distance between SNP pair")
  


ggplot(some,aes(x=dist, y = )) +
  geom_point(alpha=.2) +
  geom_point(data=als2, color="darkorange",alpha=.6) +
  geom_smooth(color="gray60") +
  theme_bw() +
  labs(x="Distance between SNPs")


###try with complete HTG2153 data

ld <- fread("illinois2153.ld",header=T)
names(ld)
ld$dist<-ld$BP_B - ld$BP_A


ggplot(ld,aes(x=dist, y = R2)) +
  geom_point(alpha=.2) +
  #geom_point(data=als2, color="darkorange",alpha=.6) +
  #geom_smooth(color="gray60") +
  theme_bw() +
  labs(x="Distance between SNPs")



library(data.table)
ld <- fread("illinois2153.geno.ld",header=T)
names(ld)
names(ld)<-c("CHR","POS1","POS2","NIND","R")

# plot the average correlation for each snp distance
ld$dist<-ld$POS2-ld$POS1
library(dplyr)
test<-ld %>% group_by(dist) %>% summarise(LDmean=mean(R))

ggplot(test,aes(x=dist, y = LDmean)) +
  geom_point(alpha=.05) +
  #geom_point(data=als2, color="darkorange",alpha=.6) +
  geom_smooth(color="gray60") +
  theme_bw() +
  labs(x="Distance between SNPs")

