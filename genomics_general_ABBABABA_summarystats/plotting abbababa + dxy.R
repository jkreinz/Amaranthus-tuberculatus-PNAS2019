############
#ABBA-BABA#
############

abbababba1<-read.csv("abba_babba_nat_walpole_essex_10kb.csv")
abbababba2<-read.csv("abba_babba_nat_walpole_illinois_10kb.csv")
abbababba3<-read.csv("abba_babba_walpole_essex_illinois_10kb.csv")
abbababba4<-read.csv("abba_babba_nat_essex_illinois_10kb.csv")
abbababba5<-read.csv("abba_babba_essex_illinois_nat.csv")
abbababba6<-read.csv("abba_babba_essex_illinois_walpole_10kb.csv")

library(wesanderson)
library(ggridges)
library(ggplot2)

#ggplot(data=abbababba,aes(x=row, y=D),group=scaffold) +
geom_point(pch=20, cex=.6, aes(color=scaffold)) +
  scale_colour_cyclical(values=wes_palette("Darjeeling")) +
  geom_smooth(method="loess",span=.03,colour="gray40") +
  labs(x="100KB windows, coloured by contig ", y="D Statistic, Nat - Walpole - Essex - Hypo") +
  geom_hline(yintercept = 0, lty=20, color="gray40") +
  theme_bw() + theme(legend.position="none",
                     axis.text.x=element_blank(),
                     axis.ticks.x=element_blank())

hist(abbababba1$D,breaks=100, main="", xlab= "D Statistic for Nat - Walpole - Essex - Hypo")
abline(v = median(abbababba1$D),lwd=2,lty="dashed")
hist(abbababba2$D,breaks=100, main="", xlab= "D Statistic for Nat - Walpole - Illinois - Hypo")
abline(v = median(abbababba2$D),lwd=2,lty="dashed")
hist(abbababba3$D,breaks=100, main="", xlab= "D Statistic for Walpole - Essex - Illinois - Hypo")
abline(v = median(abbababba3$D),lwd=2,lty="dashed")
hist(abbababba4$D,breaks=100, main="", xlab= "D Statistic for Nat - Essex - Illinois - Hypo")
abline(v = median(abbababba4$D),lwd=2,lty="dashed")
hist(abbababba5$D,breaks=100, main="", xlab= "D Statistic for Essex - Illinois - Nat - Hypo")
abline(v = median(abbababba5$D),lwd=2,lty="dashed")

mean(na.exclude(abbababba1$D))
mean(na.exclude(abbababba2$D))
mean(na.exclude(abbababba4$D))
mean(na.exclude(abbababba6$D))


######filtered stats########
#median illinois D = 0.0696
#mean illinois D = 0.08068434
#median walpole D = 0.0318
#mean walpole D = 0.03877602
#############################


######unfiltered stats########
#D median for Walpole - Nat - Essex - Hypo = -0.1078
#D median for Walpole - Essex - Nat - Hypo = -0.14885

#D median for Nat-Walpole-Essex = 0.1078
#D median for Essex-Illinois-Nat = 0.0306
#############################

abbababba$fd[abbababba$fd<0]<-0


ggplot(data=abbababba,aes(x=row, y=fd),group=scaffold) +
  geom_point(pch=20, cex=.6, aes(color=scaffold)) +
  scale_colour_cyclical(values=wes_palette("Darjeeling")) +
  geom_smooth(method="loess",span=.05,colour="gray40") +
  labs(x="100KB windows, coloured by contig ", y="Admixture Fraction b/w Walpole & Essex") +
  #geom_hline(yintercept = median((abbababba$fd)), lty=20, color="gray40") +
  ylim(0,1) +
  theme_bw() + theme(legend.position="none",
                     axis.text.x=element_blank(),
                     axis.ticks.x=element_blank())



##################
#sliding windows#
##################


popgen<-read.csv("popgenstats_5pops_10KB.csv")
popgen$win<-1:nrow(popgen)

names(popgen)

library(wesanderson)
library(ggridges)
library(ggplot2)

popgen_complete<-popgen[complete.cases(popgen), ]
names(popgen_complete)
"#0A6648","#2B537A","#007993"

#plot pi
wes_palettes$Zissou1

cols<-c("#3B9AB2","#78B7C5","#EBCC2A","#F21A00")

ggplot(data=popgen_complete) +
  geom_point(aes(win, pi_walpole), colour="#3B9AB2",pch=20, cex=.6, alpha=.05) +
  geom_point(aes(win, pi_essex), colour= "#78B7C5",pch=20, cex=.6, alpha=.05) +
  geom_point(aes(win, pi_illinois_western), colour="#EBCC2A",pch=20, cex=.6, alpha=.05) +
  geom_point(aes(win, pi_illinois_admixed), colour="#E1AF00",pch=20, cex=.6, alpha=.05) +
  geom_point(aes(win, pi_natural), colour=  "#F21A00",pch=20, cex=.6, alpha=.05) +
  geom_smooth(aes(win, pi_walpole), method="loess",span=.005,colour="#3B9AB2",se = F) +
  geom_smooth(aes(win, pi_essex), method="loess",span=.005,colour="#78B7C5",se = F) +
  geom_smooth(aes(win, pi_illinois_western), method="loess",span=.005,colour="#EBCC2A",se = F) +
  geom_smooth(aes(win, pi_illinois_admixed), method="loess",span=.005,colour="#E1AF00",se = F) +
  geom_smooth(aes(win, pi_natural), method="loess",span=.005,colour= "#F21A00",se = F) +
  geom_hline(yintercept = median(popgen_complete$pi_walpole),lty="dashed",alpha=.8,colour="#3B9AB2") +
  geom_hline(yintercept = median(popgen_complete$pi_essex),lty="dashed",alpha=.8,colour="#78B7C5") +
  geom_hline(yintercept = median(popgen_complete$pi_illinois_western),lty="dashed",alpha=.8,colour="#EBCC2A") +
  geom_hline(yintercept = median(popgen_complete$pi_illinois_admixed),lty="dashed",alpha=.8,colour="#E1AF00") +
  geom_hline(yintercept = median(popgen_complete$pi_natural),lty="dashed", alpha=.8,colour="#F21A00") +
  #scale_colour_cyclical(values=wes_palette("Darjeeling")) +
  #geom_smooth(method="loess",span=.01,colour="gray40") +
  labs(x="10KB windows", y="Pi") +
  #geom_hline(yintercept = median(na.exclude(abbababba$D)), lty=20, color="gray40") +
  theme_bw() + theme(
    axis.text.x=element_blank(),
    axis.ticks.x=element_blank())




median(na.exclude(popgen_complete$pi_walpole))
#[1]   0.1505
median(na.exclude(popgen_complete$pi_essex))
#[1] 0.1392
median(na.exclude(popgen_complete$pi_illinois_western))
#[1] 0.1382
median(na.exclude(popgen_complete$pi_illinois_admixed))
#[1] 0.1474
median(na.exclude(popgen_complete$pi_natural))
#[1] 0.1363

median(na.exclude(popgen_complete$dxy_natural_illinois_western))
#[1]   0.2201
median(na.exclude(popgen_complete$dxy_natural_illinois_admixed))
#[1]   0.2147
median(na.exclude(popgen_complete$dxy_walpole_illinois_admixed))
#[1]   0.2094
median(na.exclude(popgen_complete$dxy_walpole_natural))
#[1]   0.1542
median(na.exclude(popgen_complete$dxy_walpole_essex))
#[1]   0.1575
median(na.exclude(popgen_complete$dxy_walpole_illinois_western))
#[1]   0.2104
median(na.exclude(popgen_complete$dxy_essex_illinois_admixed))
#[1]    0.2012
median(na.exclude(popgen_complete$dxy_essex_illinois_western))
#[1]    0.1949
median(na.exclude(popgen_complete$dxy_natural_essex))
#[1]    0.1668

median(na.exclude(popgen_complete$Fst_natural_illinois_western))
#[1]   0.1984
median(na.exclude(popgen_complete$Fst_natural_illinois_admixed))
#[1]   0.1113
median(na.exclude(popgen_complete$Fst_walpole_illinois_admixed))
#[1]   0.1609
median(na.exclude(popgen_complete$Fst_walpole_natural))
#[1]   0.0201
median(na.exclude(popgen_complete$Fst_walpole_essex))
#[1]   0.0352
median(na.exclude(popgen_complete$Fst_walpole_illinois_western))
#[1]   0.1666
median(na.exclude(popgen_complete$Fst_essex_illinois_admixed))
#[1]   0.1622
median(na.exclude(popgen_complete$Fst_essex_illinois_western))
#[1]  0.1547
median(na.exclude(popgen_complete$Fst_natural_essex))
#[1]  0.0538
median(na.exclude(popgen_complete$Fst_illinois_admixed_illinois_western))
#[1] 0.0127

################################
#plot fst and dxy boxplots side by side
################################

library(dplyr)
library(reshape2)

fst<-popgen_complete[,c(31,21:30)]
long<-melt(fst, id.vars="win")
long2<-long[long$value>=0,]

dxy<-popgen_complete[,c(31,11:20)]
slong<-melt(dxy, id.vars="win")
slong2<-slong[long$value>=0,]

names(slong2)<-c("window","variable","dxy")
long2$dxy<-slong2$dxy  
names(long2)<-c("win","variable","Fst","Dxy")
long2$variable <- gsub('Fst_', '', long2$variable)
long2$variable <- gsub('dxy_', '', long2$variable)

try<-melt(long2,id.vars=c("win","variable"))
names(try)<-c("win","name","stat","value")

try$name  = factor(try$name, levels=c("walpole_natural","walpole_essex","natural_essex","essex_illinois_admixed","essex_illinois_western",
                                      "walpole_illinois_admixed","walpole_illinois_western","natural_illinois_admixed","natural_illinois_western",
                                      "illinois_admixed_illinois_western"))
levels(try$name)

library(ggplot2)
ggplot(data=try,aes(x=name,y=value, fill=stat)) +
  geom_boxplot(cex=.5) +
  theme_bw() +
  ylab("Fst  |  Dxy") +
  xlab("Between Pop. Comparison") +
  guides(fill=guide_legend(title=""))
  

  

median(na.exclude(popgen_complete$Fst_natural_illinois_western))
#[1] 0.1984


####plot Fst vs. Dxy

ggplot(data=popgen_complete) +
  geom_point(aes(win, Fst_walpole_essex), colour= "#5BBCD6",pch=20, cex=.6, alpha=.5) +
  geom_point(aes(win, dxy_walpole_essex), colour= "#F98400",pch=20, cex=.6, alpha=.5) +
  geom_smooth(aes(win, Fst_walpole_essex), method="loess",span=.01,colour="#3a7e91") +
  geom_smooth(aes(win, dxy_walpole_essex), method="loess",span=.01,colour="#a55801") +
  #scale_colour_cyclical(values=wes_palette("Darjeeling")) +
  #geom_smooth(method="loess",span=.01,colour="gray40") +
  labs(x="10KB windows, coloured by contig ", y="Dxy vs. Fst Walpole-Essex") +
  #geom_hline(yintercept = median(na.exclude(abbababba$D)), lty=20, color="gray40") +
  theme_bw() + theme(legend.position="none",
                     axis.text.x=element_blank(),
                     axis.ticks.x=element_blank())


ggplot(data=popgen_complete) +
  geom_point(aes(win, Fst_walpole_illinois), colour= "#5BBCD6",pch=20, cex=.6, alpha=.5) +
  geom_point(aes(win, dxy_walpole_illinois), colour= "#F98400",pch=20, cex=.6, alpha=.5) +
  geom_smooth(aes(win, Fst_walpole_illinois), method="loess",span=.01, colour="#3a7e91") +
  geom_smooth(aes(win, dxy_walpole_illinois), method="loess",span=.01, colour="#a55801") +
  #scale_colour_cyclical(values=wes_palette("Darjeeling")) +
  #geom_smooth(method="loess",span=.01,colour="gray40") +
  labs(x="10KB windows", y="Dxy vs. Fst Walpole-Illinois") +
  #geom_hline(yintercept = median(na.exclude(abbababba$D)), lty=20, color="gray40") +
  theme_bw() + theme(legend.position="none",
                     axis.text.x=element_blank(),
                     axis.ticks.x=element_blank())


ggplot(data=popgen_complete) +
  geom_point(aes(win, Fst_essex_illinois), colour= "#5BBCD6",pch=20, cex=.6, alpha=.5) +
  geom_point(aes(win, dxy_essex_illinois), colour= "#F98400",pch=20, cex=.6, alpha=.5) +
  geom_smooth(aes(win, Fst_essex_illinois), method="loess",span=.01, colour="#3a7e91") +
  geom_smooth(aes(win, dxy_essex_illinois), method="loess",span=.01, colour="#a55801") +
  #scale_colour_cyclical(values=wes_palette("Darjeeling")) +
  #geom_smooth(method="loess",span=.01,colour="gray40") +
  labs(x="10KB windows", y="Dxy vs. Fst Essex-Illinois") +
  #geom_hline(yintercept = median(na.exclude(abbababba$D)), lty=20, color="gray40") +
  theme_bw() + theme(legend.position="none",
                     axis.text.x=element_blank(),
                     axis.ticks.x=element_blank())

ggplot(data=popgen_complete) +
  geom_point(aes(win, Fst_essex_illinois), colour= "#5BBCD6",pch=20, cex=.6, alpha=.5) +
  geom_point(aes(win, dxy_essex_illinois), colour= "#F98400",pch=20, cex=.6, alpha=.5) +
  geom_smooth(aes(win, Fst_essex_illinois), method="loess",span=.01, colour="#3a7e91") +
  geom_smooth(aes(win, dxy_essex_illinois), method="loess",span=.01, colour="#a55801") +
  #scale_colour_cyclical(values=wes_palette("Darjeeling")) +
  #geom_smooth(method="loess",span=.01,colour="gray40") +
  labs(x="10KB windows", y="Dxy vs. Fst Essex-Illinois") +
  #geom_hline(yintercept = median(na.exclude(abbababba$D)), lty=20, color="gray40") +
  theme_bw() + theme(legend.position="none",
                     axis.text.x=element_blank(),
                     axis.ticks.x=element_blank())



ggplot(data=popgen_complete) +
  geom_point(aes(win, Fst_walpole_essex), colour= "#5BBCD6",pch=20, cex=.6, alpha=.5) +
  geom_point(aes(win, dxy_walpole_essex), colour= "#F98400",pch=20, cex=.6, alpha=.5) +
  geom_smooth(aes(win, Fst_walpole_essex), method="loess",span=.01,colour="#3a7e91") +
  geom_smooth(aes(win, dxy_walpole_essex), method="loess",span=.01,colour="#a55801") +
  #scale_colour_cyclical(values=wes_palette("Darjeeling")) +
  #geom_smooth(method="loess",span=.01,colour="gray40") +
  labs(x="10KB windows, coloured by contig ", y="Dxy vs. Fst Walpole-Essex") +
  #geom_hline(yintercept = median(na.exclude(abbababba$D)), lty=20, color="gray40") +
  theme_bw() + theme(legend.position="none",
                     axis.text.x=element_blank(),
                     axis.ticks.x=element_blank())

mean(na.exclude(popgen_complete$dxy_walpole_essex))
mean(na.exclude(popgen_complete$dxy_essex_illinois))
mean(na.exclude(popgen_complete$dxy_walpole_illinois))

mean(na.exclude(popgen_complete$Fst_walpole_essex))
mean(na.exclude(popgen_complete$Fst_essex_illinois))
mean(na.exclude(popgen_complete$Fst_walpole_illinois))]


#regress Fst vs. Dxy 

qqnorm(sqrt(popgen_complete$Fst_walpole_essex))

qqnorm((popgen_complete$dxy_walpole_essex))

ggplot(data=popgen_complete, aes(Fst_walpole_essex,dxy_walpole_essex)) +
  geom_hex() +
  theme_bw()

ggplot(data=popgen_complete, aes(Fst_walpole_essex,dxy_walpole_essex)) +
  geom_point(alpha=.4) +
  ylim(0,0.4) +
  xlim(0,0.4) +
  #geom_abline(intercept = 0.1564185, slope =0.1145622, colour="gray20") +
  geom_abline(intercept=0,slope=1,lty=20) +
  theme_bw()

ggplot(data=popgen_complete, aes(Fst_walpole_illinois,dxy_walpole_illinois)) +
  geom_point(alpha=.4) +
  ylim(0,0.4) +
  xlim(0,0.4) +
  #geom_abline(intercept = 0.1564185, slope =0.1145622, colour="gray20") +
  geom_abline(intercept=0,slope=1,lty=20) +
  theme_bw()

ggplot(data=popgen_complete, aes(Fst_essex_illinois,dxy_essex_illinois)) +
  geom_point(alpha=.4) +
  ylim(0,0.4) +
  xlim(0,0.4) +
  #geom_abline(intercept = 0.1564185, slope =0.1145622, colour="gray20") +
  geom_abline(intercept=0,slope=1,lty=20) +
  theme_bw()
