#ontario
amar<-read.csv("Dropbox/can copy number.csv")
library(ggplot2)

ggplot(amar, aes(x=pop, y=copy, fill=res)) + 
  scale_fill_manual(values=c("#663800","#09423F")) +
  xlab("") +
  ylab("# of EPSPS Copies") +#avoid plotting outliers twice
  geom_boxplot(outlier.shape=NA, alpha=.6) +
  geom_jitter(aes(color=res),position=position_jitter(width=.15, height=0),cex=3,alpha=.7) +
  guides(fill=F) +
  scale_color_manual(values=c("#663800","#09423F"),labels=c("Resistant","Suseptible"),name="") +
  ggtitle("Copy number variation across Ontario populations")


ggplot(amar, aes(x=pop, y=rating, fill=res)) + 
  scale_fill_manual(values=c("#663800","#09423F")) +
  xlab("") +
  ylab("Tolerance Rating") +#avoid plotting outliers twice
  geom_boxplot(outlier.shape=NA, alpha=.6) +
  geom_jitter(aes(color=res),position=position_jitter(width=.15, height=0),cex=3,alpha=.7) +
  guides(fill=F) +
  scale_color_manual(values=c("#663800","#09423F"),labels=c("Resistant","Suseptible"),name="") +
  ggtitle("Tolerance across Ontario populations")


ggplot(amar, aes(x=res, y=copy, fill=res)) + 
  scale_fill_manual(values=c("#663800","#09423F")) +
  xlab("") +
  ylab("# of EPSPS Copies") +#avoid plotting outliers twice
  geom_boxplot(outlier.shape=NA, alpha=.6) +
  geom_jitter(aes(color=res),position=position_jitter(width=.15, height=0),cex=3,alpha=.7) +
  guides(fill=F) +
  scale_color_manual(values=c("#663800","#09423F"),labels=c("Resistant","Suseptible"),name="") +
  ggtitle("Ontario: Copy number by resistance")


lm1<-lm(data=amar, copy~res)
summary(lm1)       

lm2<-lm(data=amar, copy~rating)
summary(lm2)  

plot(data=amar, copy~rating,pch=20, main="Ontario Copy number by Tolerance Rating")
abline(lm2[1],lm2[2])
text(1.7,27,labels = "R-squared = 0.433")

#illinois
amar<-read.csv("Dropbox/illinois copy number.csv",header=T)
library(ggplot2)

ggplot(amar, aes(x=pop, y=copy, fill=res)) + 
  scale_fill_manual(values=c("#663800","#09423F")) +
  xlab("") +
  ylab("# of EPSPS Copies") +#avoid plotting outliers twice
  geom_boxplot(outlier.shape=NA, alpha=.6) +
  geom_jitter(aes(color=res),position=position_jitter(width=.15, height=0),cex=3,alpha=.7) +
  guides(fill=F) +
  scale_color_manual(values=c("#663800","#09423F"),labels=c("Resistant","Suseptible"),name="") +
  ggtitle("Copy number variation across Illinois populations")

ggplot(amar, aes(x=pop, y=rating, fill=res)) + 
  scale_fill_manual(values=c("#663800","#09423F")) +
  xlab("") +
  ylab("Tolerance Rating") +#avoid plotting outliers twice
  geom_boxplot(outlier.shape=NA, alpha=.6) +
  geom_jitter(aes(color=res),position=position_jitter(width=.15, height=0),cex=3,alpha=.7) +
  guides(fill=F) +
  scale_color_manual(values=c("#663800","#09423F"),labels=c("Resistant","Suseptible"),name="") 

ggplot(amar, aes(x=res, y=copy, fill=res)) + 
  scale_fill_manual(values=c("#663800","#09423F")) +
  xlab("") +
  ylab("# of EPSPS Copies") +#avoid plotting outliers twice
  geom_boxplot(outlier.shape=NA, alpha=.6) +
  geom_jitter(aes(color=res),position=position_jitter(width=.15, height=0),cex=3,alpha=.7) +
  guides(fill=F) +
  scale_color_manual(values=c("#663800","#09423F"),labels=c("Resistant","Suseptible"),name="") +
  ggtitle("Illinois: Copy number by resistance")


lm1<-lm(data=amar, copy~res)
summary(lm1)       

lm2<-lm(data=amar, copy~rating)
summary(lm2)  

plot(data=amar, copy~rating,pch=20, ylab="EPSPS Copy Number by Coverage", xlab="Tolerance Rating", ylim=c(0,30),xlim=c(0,10))
abline(lm2[1],lm2[2])
text(1.7,27,labels = "R-squared = 0.297",cex=.9)

###################


amar<-read.csv("Dropbox/mediancopynumber_all2.csv",header=T)
lm3<-lm(data=amar,rating ~ country/ region/ pop)
anova(lm3)

wal<-amar[amar$region=="Walpole",]
ess<-amar[amar$region=="Essex",]
ill<-amar[amar$region=="Illinois",]
nat<-amar[amar$region=="Nat Pops",]

wal_TSR<-wal[wal$TSR=="TRUE",]
ill_TSR<-ill[ill$TSR=="TRUE",]
ess_TSR<-ess[ess$TSR=="TRUE",]

par(mfrow=c(1,3))

plot(data=wal, rating~copy,pch=20,cex=2, xlab="EPSPS Copy Number by Coverage", ylab="Tolerance Rating", ylim=c(0,10),xlim=c(0,30))
lm1<-lm(data=wal,rating~copy)
lm2<-lm(data=wal,rating~copy+TSR)
points(wal_TSR$copy,wal_TSR$rating, pch=20, col="red")
abline(lm1[1],lm1[2])
abline(lm2[1],lm2[2],lty="dashed")

plot(data=ess, rating~copy,pch=20,cex=2, xlab="EPSPS Copy Number by Coverage", ylab="", ylim=c(0,10),xlim=c(0,30))
lm1<-lm(data=ess,rating~copy)
lm2<-lm(data=ess,rating~copy+TSR)
points(ess_TSR$copy,ess_TSR$rating, pch=20, col="red")
abline(lm1[1],lm1[2])
abline(lm2[1],lm2[2],lty="dashed")

plot(data=ill, rating~copy,pch=20,cex=2, xlab="EPSPS Copy Number by Coverage", ylab="", ylim=c(0,10),xlim=c(0,30))
lm1<-lm(data=ill,rating~copy)
lm2<-lm(data=ill,rating~copy+TSR)
points(ill_TSR$copy,ill_TSR$rating, pch=20, col="red")
abline(lm1[1],lm1[2])
abline(lm2[1],lm2[2],lty="dashed")


ag<-amar[amar$region!="Nat Pops",]

library(ggplot2)
names(ag)<-c("Samples","Copy","Pop","Resistant","Rating","Country","Region")

ggplot(ag, aes(Copy, color=Region, fill=Region)) +
  geom_density(position = "fill",alpha=.8) +
  theme_bw() +
  labs(x="EPSPS Copy #", y="Density")

ggplot(ag, aes(Copy, color=Region, fill=Region)) +
  geom_density(alpha=.2) +
  theme_bw() +
  labs(x="EPSPS Copy #", y="Density")

       
hist(wal$copy,breaks=30,xlim=c(0,30))
hist(ess$copy,breaks=30,xlim=c(0,30))
hist(ill$copy,breaks=30,xlim=c(0,30))
hist(nat$copy,breaks=30,xlim=c(0,30))


region3  = factor(amar$region, levels=c("Illinois","Essex","Nat Pops","Walpole"))

lm3<-lm(data=amar,rating ~ region3)
summary(lm3)

region2  = factor(amar$region, levels=c("Nat Pops", "Walpole", "Essex", "Illinois"))

library(gridExtra)
library(grid)
library(ggplot2)
library(lattice)

p2<-ggplot(amar, aes(region2,rating,fill=region2)) +
  scale_fill_manual(values=c("#E2D200","#46ACC8","#E58601","#B40F20"),name="Region") +
  geom_jitter(aes(color=region2),position=position_jitter(width=.15, height=0),cex=3,alpha=.4) +
  scale_colour_manual(values=c("#E2D200","#46ACC8","#E58601","#B40F20"),aes(guide="Region")) +
  geom_boxplot(outlier.shape=NA, alpha=.4) +
  theme_bw() +
  xlab("Region") +
  ylab("Tolerance Rating") +
  geom_hline(yintercept = 3, lty="dashed", alpha=.5) +
  guides(fill=F, colour=F)

levels(amar$pop)
pop2  = factor(amar$pop, levels=c("N1","N3","N4","15", "16", "17", "18","19","27","4","5","6","7","9","Fayette","Madison","Massac","Morgan","Platte","Randolph","Schuyler","Union"))
levels(pop2)<-c("N1","N3","N4","15", "16", "17", "18","19","27","4","5","6","7","9","F","Md","Ms","Mo","P","R","S","U")


p1<-ggplot(amar, aes(pop2,rating, fill=region2)) +
  scale_fill_manual(values=c("#E2D200","#46ACC8","#E58601","#B40F20")) +
  geom_jitter(aes(color=region2),position=position_jitter(width=.15, height=0),cex=3,alpha=.5) +
  scale_colour_manual(values=c("#E2D200","#46ACC8","#E58601","#B40F20"),aes(guide="Region")) +
  geom_boxplot(outlier.shape=NA, alpha=.4) +
  theme_bw() +
  xlab("Population") +
  ylab("Tolerance Rating") +
  geom_hline(yintercept = 3, lty="dashed", alpha=.5) +
  guides(fill=F,color=F)
 
grid.arrange(p1, p2, nrow = 2)


ggplot(amar, aes(x=pop, y=rating)) + 
  scale_fill_manual(values=c("#663800","#09423F")) +
  xlab("") +
  ylab("# of EPSPS Copies") +#avoid plotting outliers twice
  geom_boxplot(outlier.shape=NA, alpha=.6) +
  geom_jitter(aes(color=res),position=position_jitter(width=.15, height=0),cex=3,alpha=.7) +
  guides(fill=F) +
  scale_color_manual(values=c("#663800","#09423F"),labels=c("Resistant","Suseptible"),name="") +
  ggtitle("")

