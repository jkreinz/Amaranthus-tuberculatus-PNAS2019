library(data.table)
#install.packages("ggridges")
library(ggridges)
library(ggplot2)
#install.packages("devtools")
library(devtools)
#install.packages("wesanderson")
library("wesanderson")
#names(wes_palettes)

cov<-fread("allsamples.cov") #output from vcftools genotype coverage
names(cov)<-c("pos","15_10","15_11","15_3","15_5","15_6","15_7","16_1","16_2","16_3","16_5","16_6","16_7","16_8","16_9","17_10","17_11","17_1","17_3","17_4","17_6","17_7","17_9","18_11","18_15","18_16","18_1","18_2","18_3","19_1_1","19_1_3","19_3","19_4","19_5","19_6","27_10","27_2","27_3","27_4","27_5","27_6","27_8","27_9","4_11","4_12","4_13","4_16","4_18","4_1","4_2","4_5","4_8","4_9","5_10","5_15","5_16","5_19","5_1","5_2","5_4","5_7","5_8","6_10","6_2","6_3","6_5","6_6","6_7","6_9","7_10","7_12","7_14","7_2","7_5","7_7","9_10","9_11","9_1","9_4","9_5","9_6","9_7","9_9","B10","B11","B13","B16","B19","B1","B3","B4","B7","B9","D10","D11","D12","D14","D15","D1","D2","D4","D5","D6","E10","E14","E15","E19","E2","E3","E6","E7","F10","F11","F12","F13","F1","F4","F5","F7","F9","G10","G11","G13","G15","G2","G5","G7","H10","H11","H14","H1","H2","H4","H6","H8","H9","J11","J18","J1","J2","J3","J4","J5","J6","J8","J9","K13","K15","K16","K19","K20","K2","K3","K4","K6","K8","N1_1","N1_2","N1_3","N1_5","N1_6","N3_1","N3_2","N3_3","N4_2","N4_3")

epsps<-cov[which(cov$pos>400000),]
epsps<-epsps[which(epsps$pos<430000),]


epsps$`15_10`<-epsps$`15_10`/11
epsps$`15_11`<-epsps$`15_11`/14
epsps$`15_3`<-epsps$`15_3`/11
epsps$`15_5`<-epsps$`15_5`/11
epsps$`15_6`<-epsps$`15_6`/10
epsps$`15_7`<-epsps$`15_7`/14
epsps$`16_1`<-epsps$`16_1`/11
epsps$`16_2`<-epsps$`16_2`/9
epsps$`16_3`<-epsps$`16_3`/12
epsps$`16_5`<-epsps$`16_5`/12
epsps$`16_6`<-epsps$`16_6`/11
epsps$`16_7`<-epsps$`16_7`/11
epsps$`16_8`<-epsps$`16_8`/19
epsps$`16_9`<-epsps$`16_9`/11
epsps$`17_10`<-epsps$`17_10`/10
epsps$`17_11`<-epsps$`17_11`/11
epsps$`17_1`<-epsps$`17_1`/12
epsps$`17_3`<-epsps$`17_3`/11
epsps$`17_4`<-epsps$`17_4`/11
epsps$`17_6`<-epsps$`17_6`/12
epsps$`17_7`<-epsps$`17_7`/13
epsps$`17_9`<-epsps$`17_9`/13
epsps$`18_11`<-epsps$`18_11`/15
epsps$`18_15`<-epsps$`18_15`/10
epsps$`18_16`<-epsps$`18_16`/19
epsps$`18_1`<-epsps$`18_1`/20
epsps$`18_2`<-epsps$`18_2`/10
epsps$`18_3`<-epsps$`18_3`/20
epsps$`19_1_1`<-epsps$`19_1_1`/9
epsps$`19_1_3`<-epsps$`19_1_3`/9
epsps$`19_3`<-epsps$`19_3`/10
epsps$`19_4`<-epsps$`19_4`/14
epsps$`19_5`<-epsps$`19_5`/13
epsps$`19_6`<-epsps$`19_6`/14
epsps$`27_10`<-epsps$`27_10`/16
epsps$`27_2`<-epsps$`27_2`/13
epsps$`27_3`<-epsps$`27_3`/14
epsps$`27_4`<-epsps$`27_4`/10
epsps$`27_5`<-epsps$`27_5`/10
epsps$`27_6`<-epsps$`27_6`/10
epsps$`27_8`<-epsps$`27_8`/11
epsps$`27_9`<-epsps$`27_9`/16
epsps$`4_11`<-epsps$`4_11`/11
epsps$`4_12`<-epsps$`4_12`/16
epsps$`4_13`<-epsps$`4_13`/14
epsps$`4_16`<-epsps$`4_16`/13
epsps$`4_18`<-epsps$`4_18`/12
epsps$`4_1`<-epsps$`4_1`/16
epsps$`4_2`<-epsps$`4_2`/17
epsps$`4_5`<-epsps$`4_5`/10
epsps$`4_8`<-epsps$`4_8`/16
epsps$`4_9`<-epsps$`4_9`/21
epsps$`5_10`<-epsps$`5_10`/12
epsps$`5_15`<-epsps$`5_15`/14
epsps$`5_16`<-epsps$`5_16`/12
epsps$`5_19`<-epsps$`5_19`/17
epsps$`5_1`<-epsps$`5_1`/10
epsps$`5_2`<-epsps$`5_2`/12
epsps$`5_4`<-epsps$`5_4`/16
epsps$`5_7`<-epsps$`5_7`/12
epsps$`5_8`<-epsps$`5_8`/11
epsps$`6_10`<-epsps$`6_10`/9
epsps$`6_2`<-epsps$`6_2`/11
epsps$`6_3`<-epsps$`6_3`/12
epsps$`6_5`<-epsps$`6_5`/11
epsps$`6_6`<-epsps$`6_6`/12
epsps$`6_7`<-epsps$`6_7`/21
epsps$`6_9`<-epsps$`6_9`/46
epsps$`7_10`<-epsps$`7_10`/14
epsps$`7_12`<-epsps$`7_12`/11
epsps$`7_14`<-epsps$`7_14`/12
epsps$`7_2`<-epsps$`7_2`/17
epsps$`7_5`<-epsps$`7_5`/11
epsps$`7_7`<-epsps$`7_7`/12
epsps$`9_10`<-epsps$`9_10`/14
epsps$`9_11`<-epsps$`9_11`/20
epsps$`9_1`<-epsps$`9_1`/12
epsps$`9_4`<-epsps$`9_4`/20
epsps$`9_5`<-epsps$`9_5`/17
epsps$`9_6`<-epsps$`9_6`/13
epsps$`9_7`<-epsps$`9_7`/15
epsps$`9_9`<-epsps$`9_9`/15
epsps$`B10`<-epsps$`B10`/16
epsps$`B11`<-epsps$`B11`/19
epsps$`B13`<-epsps$`B13`/22
epsps$`B16`<-epsps$`B16`/18
epsps$`B19`<-epsps$`B19`/16
epsps$`B1`<-epsps$`B1`/15
epsps$`B3`<-epsps$`B3`/16
epsps$`B4`<-epsps$`B4`/19
epsps$`B7`<-epsps$`B7`/20
epsps$`B9`<-epsps$`B9`/16
epsps$`D10`<-epsps$`D10`/21
epsps$`D11`<-epsps$`D11`/16
epsps$`D12`<-epsps$`D12`/18
epsps$`D14`<-epsps$`D14`/16
epsps$`D15`<-epsps$`D15`/20
epsps$`D1`<-epsps$`D1`/17
epsps$`D2`<-epsps$`D2`/16
epsps$`D4`<-epsps$`D4`/17
epsps$`D5`<-epsps$`D5`/16
epsps$`D6`<-epsps$`D6`/19
epsps$`E10`<-epsps$`E10`/21
epsps$`E14`<-epsps$`E14`/17
epsps$`E15`<-epsps$`E15`/18
epsps$`E19`<-epsps$`E19`/13
epsps$`E2`<-epsps$`E2`/15
epsps$`E3`<-epsps$`E3`/17
epsps$`E6`<-epsps$`E6`/17
epsps$`E7`<-epsps$`E7`/16
epsps$`F10`<-epsps$`F10`/15
epsps$`F11`<-epsps$`F11`/14
epsps$`F12`<-epsps$`F12`/15
epsps$`F13`<-epsps$`F13`/17
epsps$`F1`<-epsps$`F1`/18
epsps$`F4`<-epsps$`F4`/16
epsps$`F5`<-epsps$`F5`/18
epsps$`F7`<-epsps$`F7`/16
epsps$`F9`<-epsps$`F9`/15
epsps$`G10`<-epsps$`G10`/17
epsps$`G11`<-epsps$`G11`/18
epsps$`G13`<-epsps$`G13`/20
epsps$`G15`<-epsps$`G15`/17
epsps$`G2`<-epsps$`G2`/17
epsps$`G5`<-epsps$`G5`/16
epsps$`G7`<-epsps$`G7`/19
epsps$`H10`<-epsps$`H10`/16
epsps$`H11`<-epsps$`H11`/16
epsps$`H14`<-epsps$`H14`/15
epsps$`H1`<-epsps$`H1`/17
epsps$`H2`<-epsps$`H2`/19
epsps$`H4`<-epsps$`H4`/17
epsps$`H6`<-epsps$`H6`/17
epsps$`H8`<-epsps$`H8`/17
epsps$`H9`<-epsps$`H9`/18
epsps$`J11`<-epsps$`J11`/13
epsps$`J18`<-epsps$`J18`/13
epsps$`J1`<-epsps$`J1`/15
epsps$`J2`<-epsps$`J2`/13
epsps$`J3`<-epsps$`J3`/12
epsps$`J4`<-epsps$`J4`/13
epsps$`J5`<-epsps$`J5`/13
epsps$`J6`<-epsps$`J6`/12
epsps$`J8`<-epsps$`J8`/12
epsps$`J9`<-epsps$`J9`/14
epsps$`K13`<-epsps$`K13`/16
epsps$`K15`<-epsps$`K15`/15
epsps$`K16`<-epsps$`K16`/16
epsps$`K19`<-epsps$`K19`/15
epsps$`K20`<-epsps$`K20`/16
epsps$`K2`<-epsps$`K2`/15
epsps$`K3`<-epsps$`K3`/14
epsps$`K4`<-epsps$`K4`/14
epsps$`K6`<-epsps$`K6`/13
epsps$`K8`<-epsps$`K8`/14
epsps$`N1_1`<-epsps$`N1_1`/26
epsps$`N1_2`<-epsps$`N1_2`/20
epsps$`N1_3`<-epsps$`N1_3`/17
epsps$`N1_5`<-epsps$`N1_5`/13
epsps$`N1_6`<-epsps$`N1_6`/14
epsps$`N3_1`<-epsps$`N3_1`/11
epsps$`N3_2`<-epsps$`N3_2`/20
epsps$`N3_3`<-epsps$`N3_3`/15
epsps$`N4_2`<-epsps$`N4_2`/18
epsps$`N4_3`<-epsps$`N4_3`/19

lm3<-aov(data=amar,copy~ region/ pop)
summary(lm3)
#test<-as.data.frame(apply(epsps,2,function(x) c(mean = mean(x))))
#plot(epsps$N3_3 ~ epsps$pos)
resistant<-subset(epsps,select=c("pos","15_10","15_6","16_3","17_10","17_11","17_3","17_4","17_6","17_7","17_9","18_15","18_16","18_1","18_2","18_3","19_1_1","19_3","19_4","19_5","27_10","27_3","27_4","27_5","27_6","27_8","27_9","4_12","4_16","4_18","4_2","4_8","4_9","5_15","5_16","5_19","5_1","5_2","5_4","5_7","5_8","6_10","6_3","6_5","7_10","7_12","7_14","7_2","7_5","9_4","9_5","9_6","9_7","B13","B16","B19","B3","B7","D10","D11","D12","D2","D5","E10","E14","E19","E6","E7","F10","F11","F4","F5","G10","G11","G15","G5","G7","H11","H14","H1","H9","J11","J18","J1","J3","J4","K13","K16","K20","K4","K8"))
walpole<-names(resistant)[2:27]
essex<-names(resistant)[28:53]
illinois<-names(resistant)[54:91]
longcov<-melt(resistant,id='pos') #change to long format data
names(longcov)<-c("pos","ind","cov")
write.table(longcov,file="longcov.txt",quote=F)


for (i in 1:nrow(longcov)){
  if (longcov$ind[i] %in% walpole) {
    longcov$pop<-"Walpole"
  } else if (longcov$ind[i] %in% essex) {
    longcov$pop<-"Essex"
  } else if (longcov$ind[i] %in% illinois) {
    longcov$pop<-"Illinois"
  }  else {
      longcov$pop<-"Natural Pops"
  }
}
  
longcov$pop[1:779974]<-"Walpole"
longcov$pop[779975:1558626]<-"Essex"
longcov$pop[1558626:2699910]<-"Illinois"


#options("scipen"=100, "digits"=4)

#library(robustbase)
#test<-as.data.frame(colMedians(as.matrix(epsps)))
#test$samples<-names(epsps)
#write.csv(test,"mediancopynumber.txt",quote=F,row.names = F)

#402110 + ((402328 - 402110)/2) 
#402430 + ((402491 - 402430)/2)
#404085 + ((404295 - 404085)/2)
#404654 + ((404771 - 404654)/2)
#404850 + ((405064 - 404850)/2)
#406532 + ((406685 - 406532)/2)
#409382 + ((409626 - 409382)/2)
#412079 + ((412411 - 412079)/2)

#install.packages("viridis")
 
library(viridis)

#plot walpole
epsps2<-resistant[,c(1:27)]
longcov2<-melt(epsps2,id='pos') #change to long format data
names(longcov2)<-c("pos","ind","cov")
ggplot(longcov2, aes(x=pos,y=ind, height=cov,fill=cov)) +
  geom_density_ridges_gradient(stat="identity",scale=1,size=0.07, panel_scaling = F) +
  geom_vline(xintercept = 402219, alpha=.7) +
  geom_vline(xintercept = 402460, alpha=.7) +
  geom_vline(xintercept = 404190, alpha=.7) +
  geom_vline(xintercept = 404712, alpha=.7) +
  geom_vline(xintercept = 404957, alpha=.7) +
  geom_vline(xintercept = 406608, alpha=.7) +
  geom_vline(xintercept = 409504, alpha=.7) +
  geom_vline(xintercept = 412245, alpha=.7) +
  geom_vline(xintercept = 412731,linetype = 2, aes(colour="#c1c1c1"),size=1.0,alpha=.7) +
  geom_vline(xintercept = 401724, linetype = 2, aes(colour="#c1c1c1"),size=1.0,alpha=.7) +
  scale_fill_viridis(discrete=F, direction = -1, name="Copy Number \n",limits=c(0,50),guide=F) +
  theme_ridges() +
  ggtitle("Walpole")


##############


#plot essex
epsps3<-resistant[,c(1,28:53)]
longcov3<-melt(epsps3,id='pos') #change to long format data
names(longcov3)<-c("pos","ind","cov")

ggplot(longcov3, aes(x=pos,y=ind, height=cov,fill=cov)) +
  geom_density_ridges_gradient(stat="identity",scale=1,size=0.07, panel_scaling = F) +
  geom_vline(xintercept = 402219, alpha=.7) +
  geom_vline(xintercept = 402460, alpha=.7) +
  geom_vline(xintercept = 404190, alpha=.7) +
  geom_vline(xintercept = 404712, alpha=.7) +
  geom_vline(xintercept = 404957, alpha=.7) +
  geom_vline(xintercept = 406608, alpha=.7) +
  geom_vline(xintercept = 409504, alpha=.7) +
  geom_vline(xintercept = 412245, alpha=.7) +
  geom_vline(xintercept = 412731,linetype = 2, aes(colour="#c1c1c1"),size=1.0,alpha=.7) +
  geom_vline(xintercept = 401724, linetype = 2, aes(colour="#c1c1c1"),size=1.0,alpha=.7) +
  scale_fill_viridis(discrete=F, direction = -1, name="Copy Number \n",limits=c(0,50)) +
  theme_ridges() +  ggtitle("Essex")

#plot illinois
epsps4<-resistant[,c(1,54:91)]
longcov4<-melt(epsps4,id='pos') #change to long format data
names(longcov4)<-c("pos","ind","cov")

ggplot(longcov4, aes(x=pos,y=ind, height=cov,fill=cov)) +
  geom_density_ridges_gradient(stat="identity",scale=1,size=0.07, panel_scaling = F) +
  geom_vline(xintercept = 402219, alpha=.7) +
  geom_vline(xintercept = 402460, alpha=.7) +
  geom_vline(xintercept = 404190, alpha=.7) +
  geom_vline(xintercept = 404712, alpha=.7) +
  geom_vline(xintercept = 404957, alpha=.7) +
  geom_vline(xintercept = 406608, alpha=.7) +
  geom_vline(xintercept = 409504, alpha=.7) +
  geom_vline(xintercept = 412245, alpha=.7) +
  geom_vline(xintercept = 412731,linetype = 2, aes(colour="#c1c1c1"),size=1.0,alpha=.7) +
  geom_vline(xintercept = 401724, linetype = 2, aes(colour="#c1c1c1"),size=1.0,alpha=.7) +
  scale_fill_viridis(discrete=F, direction = -1, name="Copy Number \n",limits=c(0,50)) +
  ggtitle("Illinois") +
  theme_ridges()


#plot nat
epsps5<-epsps[,c(1,157:166)]
longcov5<-melt(epsps5,id='pos') #change to long format data
names(longcov5)<-c("pos","ind","cov")

ggplot(longcov5, aes(x=pos,y=ind, height=cov,fill=cov)) +
  geom_density_ridges_gradient(stat="identity",scale=1,size=0.07, panel_scaling = F) +
  geom_vline(xintercept = 402219, alpha=.7) +
  geom_vline(xintercept = 402460, alpha=.7) +
  geom_vline(xintercept = 404190, alpha=.7) +
  geom_vline(xintercept = 404712, alpha=.7) +
  geom_vline(xintercept = 404957, alpha=.7) +
  geom_vline(xintercept = 406608, alpha=.7) +
  geom_vline(xintercept = 409504, alpha=.7) +
  geom_vline(xintercept = 412245, alpha=.7) +
  geom_vline(xintercept = 412731,linetype = 2, aes(colour="#c1c1c1"),size=1.0,alpha=.7) +
  geom_vline(xintercept = 401724, linetype = 2, aes(colour="#c1c1c1"),size=1.0,alpha=.7) +
  scale_fill_viridis(discrete=F, direction = -1, name="Copy Number \n",limits=c(0,50)) +
  theme_ridges() +  ggtitle("Natural Pops")



mean(longcov$meancov)
median(longcov$meancov)
