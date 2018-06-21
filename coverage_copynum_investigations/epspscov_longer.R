library(data.table)
#install.packages("ggridges")
library(ggridges)
library(ggplot2)
#install.packages("devtools")
library(devtools)
#install.packages("wesanderson")
library("wesanderson")
#names(wes_palettes)

cov<-fread("~/allsamples.cov") #output from vcftools genotype coverage
names(cov)<-c("pos","15_10","15_11","15_3","15_5","15_6","15_7","16_1","16_2","16_3","16_5","16_6","16_7","16_8","16_9","17_10","17_11","17_1","17_3","17_4","17_6","17_7","17_9","18_11","18_15","18_16","18_1","18_2","18_3","19_1_1","19_1_3","19_3","19_4","19_5","19_6","27_10","27_2","27_3","27_4","27_5","27_6","27_8","27_9","4_11","4_12","4_13","4_16","4_18","4_1","4_2","4_5","4_8","4_9","5_10","5_15","5_16","5_19","5_1","5_2","5_4","5_7","5_8","6_10","6_2","6_3","6_5","6_6","6_7","6_9","7_10","7_12","7_14","7_2","7_5","7_7","9_10","9_11","9_1","9_4","9_5","9_6","9_7","9_9","B10","B11","B13","B16","B19","B1","B3","B4","B7","B9","D10","D11","D12","D14","D15","D1","D2","D4","D5","D6","E10","E14","E15","E19","E2","E3","E6","E7","F10","F11","F12","F13","F1","F4","F5","F7","F9","G10","G11","G13","G15","G2","G5","G7","H10","H11","H14","H1","H2","H4","H6","H8","H9","J11","J18","J1","J2","J3","J4","J5","J6","J8","J9","K13","K15","K16","K19","K20","K2","K3","K4","K6","K8","N1_1","N1_2","N1_3","N1_5","N1_6","N3_1","N3_2","N3_3","N4_2","N4_3")

epsps<-cov[which(cov$pos>1),]
epsps<-epsps[which(epsps$pos<542761),]

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
epsps$`27_1`<-epsps$`27_10`/16
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

#means<-colMeans(epsps)
#
#install.packages("robustbase")
library(robustbase)

#get r2 of median coverage per individual and tolerance across windows

library(dplyr)
walpole_windowed<- epsps %>% mutate(win=floor(pos/250)) %>% group_by(win) %>% summarise(minpos=min(pos), maxpos=max(pos),`15_10`=median(`15_10`),`15_11`=median(`15_11`),`15_3`=median(`15_3`),`15_5`=median(`15_5`),`15_6`=median(`15_6`),`15_7`=median(`15_7`),`16_1`=median(`16_1`),`16_2`=median(`16_2`),`16_3`=median(`16_3`),`16_5`=median(`16_5`),`16_6`=median(`16_6`),`16_7`=median(`16_7`),`16_8`=median(`16_8`),`16_9`=median(`16_9`),`17_10`=median(`17_10`),`17_11`=median(`17_11`),`17_1`=median(`17_1`),`17_3`=median(`17_3`),`17_4`=median(`17_4`),`17_6`=median(`17_6`),`17_7`=median(`17_7`),`17_9`=median(`17_9`),`18_11`=median(`18_11`),`18_15`=median(`18_15`),`18_16`=median(`18_16`),`18_1`=median(`18_1`),`18_2`=median(`18_2`),`18_3`=median(`18_3`),`19_1_1`=median(`19_1_1`),`19_1_3`=median(`19_1_3`),`19_3`=median(`19_3`),`19_4`=median(`19_4`),`19_5`=median(`19_5`),`19_6`=median(`19_6`),`27_10`=median(`27_10`),`27_2`=median(`27_2`),`27_3`=median(`27_3`),`27_4`=median(`27_4`),`27_5`=median(`27_5`),`27_6`=median(`27_6`),`27_8`=median(`27_8`),`27_9`=median(`27_9`))
essex_windowed<- epsps %>% mutate(win=floor(pos/250)) %>% group_by(win) %>% summarise(minpos=min(pos), maxpos=max(pos),`4_11`=median(`4_11`),`4_12`=median(`4_12`),`4_13`=median(`4_13`),`4_16`=median(`4_16`),`4_18`=median(`4_18`),`4_1`=median(`4_1`),`4_2`=median(`4_2`),`4_5`=median(`4_5`),`4_8`=median(`4_8`),`4_9`=median(`4_9`),`5_10`=median(`5_10`),`5_15`=median(`5_15`),`5_16`=median(`5_16`),`5_19`=median(`5_19`),`5_1`=median(`5_1`),`5_2`=median(`5_2`),`5_4`=median(`5_4`),`5_7`=median(`5_7`),`5_8`=median(`5_8`),`6_10`=median(`6_10`),`6_2`=median(`6_2`),`6_3`=median(`6_3`),`6_5`=median(`6_5`),`6_6`=median(`6_6`),`6_7`=median(`6_7`),`6_9`=median(`6_9`),`7_10`=median(`7_10`),`7_12`=median(`7_12`),`7_14`=median(`7_14`),`7_2`=median(`7_2`),`7_5`=median(`7_5`),`7_7`=median(`7_7`),`9_10`=median(`9_10`),`9_11`=median(`9_11`),`9_1`=median(`9_1`),`9_4`=median(`9_4`),`9_5`=median(`9_5`),`9_6`=median(`9_6`),`9_7`=median(`9_7`),`9_9`=median(`9_9`))
illinois_windowed<- epsps %>% mutate(win=floor(pos/250)) %>% group_by(win) %>% summarise(minpos=min(pos), maxpos=max(pos),`B10`=median(`B10`),`B11`=median(`B11`),`B13`=median(`B13`),`B16`=median(`B16`),`B19`=median(`B19`),`B1`=median(`B1`),`B3`=median(`B3`),`B4`=median(`B4`),`B7`=median(`B7`),`B9`=median(`B9`),`D10`=median(`D10`),`D11`=median(`D11`),`D12`=median(`D12`),`D14`=median(`D14`),`D15`=median(`D15`),`D1`=median(`D1`),`D2`=median(`D2`),`D4`=median(`D4`),`D5`=median(`D5`),`D6`=median(`D6`),`E10`=median(`E10`),`E14`=median(`E14`),`E15`=median(`E15`),`E19`=median(`E19`),`E2`=median(`E2`),`E3`=median(`E3`),`E6`=median(`E6`),`E7`=median(`E7`),`F10`=median(`F10`),`F11`=median(`F11`),`F12`=median(`F12`),`F13`=median(`F13`),`F1`=median(`F1`),`F4`=median(`F4`),`F5`=median(`F5`),`F7`=median(`F7`),`F9`=median(`F9`),`G10`=median(`G10`),`G11`=median(`G11`),`G13`=median(`G13`),`G15`=median(`G15`),`G2`=median(`G2`),`G5`=median(`G5`),`G7`=median(`G7`),`H10`=median(`H10`),`H11`=median(`H11`),`H14`=median(`H14`),`H1`=median(`H1`),`H2`=median(`H2`),`H4`=median(`H4`),`H6`=median(`H6`),`H8`=median(`H8`),`H9`=median(`H9`),`J11`=median(`J11`),`J18`=median(`J18`),`J1`=median(`J1`),`J2`=median(`J2`),`J3`=median(`J3`),`J4`=median(`J4`),`J5`=median(`J5`),`J6`=median(`J6`),`J8`=median(`J8`),`J9`=median(`J9`),`K13`=median(`K13`),`K15`=median(`K15`),`K16`=median(`K16`),`K19`=median(`K19`),`K20`=median(`K20`),`K2`=median(`K2`),`K3`=median(`K3`),`K4`=median(`K4`),`K6`=median(`K6`),`K8`=median(`K8`))
#`N1_1`=median(`N1_1`),`N1_2`=median(`N1_2`),`N1_3`=median(`N1_3`),`N1_5`=median(`N1_5`),`N1_6`=median(`N1_6`),`N3_1`=median(`N3_1`),`N3_2`=median(`N3_2`),`N3_3`=median(`N3_3`),`N4_2`=median(`N4_2`),`N4_3`=median(`N4_3`))

walpole_windowed$midpos<-round(walpole_windowed$minpos+((walpole_windowed$maxpos-walpole_windowed$minpos)/2))
essex_windowed$midpos<-round(essex_windowed$minpos+((essex_windowed$maxpos-essex_windowed$minpos)/2))
illinois_windowed$midpos<-round(illinois_windowed$minpos+((illinois_windowed$maxpos-illinois_windowed$minpos)/2))

walpole_windowed_inds<-walpole_windowed[,4:45]
walpole_windowed_inds<-as.data.frame(walpole_windowed_inds)
essex_windowed_inds<-essex_windowed[,4:43]
essex_windowed_inds<-as.data.frame(essex_windowed_inds)
illinois_windowed_inds<-illinois_windowed[,4:76]
illinois_windowed_inds<-as.data.frame(illinois_windowed_inds)

wal_tolerances<-c(3,0,1,0,3,0,0,1,2,1,0,0,1,1,6,10,0,8,3,6,3.5,7,1,9,7,8,8,3,4,0,10,6,6,1,6,0,4,2,5,7,2,8)
essex_tolerances<-c(0,3,0,2,3,0,4,0,2,4,0,6,5,7,5,2,4,3,6,3,0,3,5,0,0,0,6,5,4,6,6,0,1,1,0,3,2,4,2,0)
ill_tolerances<-c(1,1,7.6,8.55,7.6,1,5.7,1,9.5,1,7.6,5.7,5.7,1,1,1,5.7,1,9.5,1,9.5,7.6,1,7.6,1,1,7.6,7.6,5.7,6.65,1,1,1,5.7,7.6,1,1,9.5,9.5,1,7.6,1,9.5,9.5,1,7.6,6.65,5.7,1,1,1,1,5.7,5.7,5.7,5.7,1,7.6,9.5,1,1,1,1,7.6,1,7.6,1,7.6,1,1,5.7,1,7.6)

wal_tolerances<-c(1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,0,1,1,1,0,1,0,1,1,1,1,1,1)
essex_tolerances<-c(0,0,1,0,1,1,1,0,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,0,0,0,1,1,1,1,1,0,0,0,0,1,1,1,1,0)
ill_tolerances<-c(0,0,0,1,1,1,1,0,1,0,0,1,1,1,0,0,1,0,1,0,1,1,0,1,0,0,1,1,0,1,1,0,0,1,1,0,0,1,1,0,1,0,1,1,1,0,1,1,0,0,0,0,1,1,1,1,0,1,1,0,0,0,0,1,0,1,0,0,1,0,1,0,1)


#get r2 by looping a linear model of rowise coverage acrosss individuals for each window and tolerances by region
walpole_coefs <- matrix(NA, ncol = 1, nrow = 2171)

for(i in 1:2171){
  walpole_cov_perwin<-unlist(as.vector(walpole_windowed_inds[i,]))
  walpole_coefs[i,] <- summary(lm(wal_tolerances~walpole_cov_perwin))$r.squared
}

walpole_coefs<-as.data.frame(walpole_coefs)
walpole_coefs$win<-walpole_windowed$win
walpole_coefs$midpos<-walpole_windowed$midpos

###

essex_coefs <- matrix(NA, ncol = 1, nrow = 2171)

for(i in 1:2171){
  essex_cov_perwin<-unlist(as.vector(essex_windowed_inds[i,]))
  essex_coefs[i,] <- summary(lm(essex_tolerances~essex_cov_perwin))$r.squared
}

essex_coefs<-as.data.frame(essex_coefs)
essex_coefs$win<-essex_windowed$win
essex_coefs$midpos<-essex_windowed$midpos

###
illinois_coefs <- matrix(NA, ncol = 1, nrow = 2171)

for(i in 1:2171){
  illinois_cov_perwin<-unlist(as.vector(illinois_windowed_inds[i,]))
  illinois_coefs[i,] <- summary(lm(ill_tolerances~illinois_cov_perwin))$r.squared
}

illinois_coefs<-as.data.frame(illinois_coefs)
illinois_coefs$win<-illinois_windowed$win
illinois_coefs$midpos<-illinois_windowed$midpos

#plot
max(walpole_coefs$V1)
max(essex_coefs$V1)
max(illinois_coefs$V1)

walpole_check<-walpole_coefs[which(walpole_coefs$midpos>401724),]
walpole_check<-walpole_check[which(walpole_check$midpos<412731),]

essex_check<-essex_coefs[which(essex_coefs$midpos>401724),]
essex_check<-essex_check[which(essex_check$midpos<412731),]

illinois_check<-illinois_coefs[which(illinois_coefs$midpos>401724),]
illinois_check<-illinois_check[which(illinois_check$midpos<412731),]


median(walpole_check$V1)
median(essex_check$V1)
median(illinois_check$V1)

401724


library(wesanderson)
cols<-wes_palette("Darjeeling1")
cols

ggplot(data=) +
  geom_point(data=walpole_coefs,aes(midpos,V1),alpha=.3,colour=cols[2]) +
  geom_point(data=essex_coefs,aes(midpos,V1),alpha=.3,colour=cols[3]) +
  geom_point(data=illinois_coefs,aes(midpos,V1),alpha=.3,colour=cols[1]) +
  geom_smooth(data=walpole_coefs,aes(midpos,V1),method="loess",span=.1,colour=cols[2]) +
  geom_smooth(data=essex_coefs,aes(midpos,V1),method="loess",span=.1,colour=cols[3]) +
  geom_smooth(data=illinois_coefs,aes(midpos,V1),method="loess",span=.1,colour=cols[1]) +
  theme_bw() +
  labs(y="r2 (Copy Number ~ Resistance)", x="250bp Window Midpoint")










######################
#get median coverage per region
#######################

resistant_wal<-subset(epsps,select=c("15_10","15_6","16_3","17_10","17_11","17_3","17_4","17_6","17_7","17_9","18_15","18_16","18_1","18_2","18_3","19_1_1","19_3","19_4","19_5","27_10","27_3","27_4","27_5","27_6","27_8","27_9"))
resistant_ess<-subset(epsps,select=c("4_12","4_16","4_18","4_2","4_8","4_9","5_15","5_16","5_19","5_1","5_2","5_4","5_7","5_8","6_10","6_3","6_5","7_10","7_12","7_14","7_2","7_5","9_4","9_5","9_6","9_7"))
resistant_ill<-subset(epsps,select=c("B13","B16","B19","B3","B7","D10","D11","D12","D2","D5","E10","E14","E19","E6","E7","F10","F11","F4","F5","G10","G11","G15","G5","G7","H11","H14","H1","H9","J11","J18","J1","J3","J4","K13","K16","K20","K4","K8"))

susceptible<- epsps[ ,-c("pos","15_10","15_6","16_3","17_10","17_11","17_3","17_4","17_6","17_7","17_9","18_15","18_16","18_1","18_2","18_3","19_1_1","19_3","19_4","19_5","27_10","27_3","27_4","27_5","27_6","27_8","27_9","4_12","4_16","4_18","4_2","4_8","4_9","5_15","5_16","5_19","5_1","5_2","5_4","5_7","5_8","6_10","6_3","6_5","7_10","7_12","7_14","7_2","7_5","9_4","9_5","9_6","9_7","B13","B16","B19","B3","B7","D10","D11","D12","D2","D5","E10","E14","E19","E6","E7","F10","F11","F4","F5","G10","G11","G15","G5","G7","H11","H14","H1","H9","J11","J18","J1","J3","J4","K13","K16","K20","K4","K8")]
susceptible_wal<- susceptible[ ,c(76,1:16)]
susceptible_ess<- susceptible[ ,17:30]
susceptible_ill<- susceptible[ ,31:76]

res_wal_var<-apply(resistant_wal,1,var)
sus_wal_var<-apply(susceptible_wal,1,var)

res_wal_var<-as.data.frame(res_wal_var)
sus_wal_var<-as.data.frame(sus_wal_var)
res_wal_var$POS<-epsps$pos
sus_wal_var$POS<-epsps$pos
names(res_wal_var)<-c("Variance","Position")
names(sus_wal_var)<-c("Variance","Position")
res_wal_var$Median<-rowMedians(as.matrix(resistant_wal))
sus_wal_var$Median<-rowMedians(as.matrix(susceptible_wal))

res_ess_var<-apply(resistant_ess,1,var)
sus_ess_var<-apply(susceptible_ess,1,var)

res_ess_var<-as.data.frame(res_ess_var)
sus_ess_var<-as.data.frame(sus_ess_var)
res_ess_var$POS<-epsps$pos
sus_ess_var$POS<-epsps$pos
names(res_ess_var)<-c("Variance","Position")
names(sus_ess_var)<-c("Variance","Position")
sus_ess_var$Median<-rowMedians(as.matrix(susceptible_ess))
res_ess_var$Median<-rowMedians(as.matrix(resistant_ess))


res_ill_var<-apply(resistant_ill,1,var)
sus_ill_var<-apply(susceptible_ill,1,var)

res_ill_var<-as.data.frame(res_ill_var)
sus_ill_var<-as.data.frame(sus_ill_var)
res_ill_var$POS<-epsps$pos
sus_ill_var$POS<-epsps$pos
names(res_ill_var)<-c("Variance","Position")
names(sus_ill_var)<-c("Variance","Position")
sus_ill_var$Median<-rowMedians(as.matrix(susceptible_ill))
res_ill_var$Median<-rowMedians(as.matrix(resistant_ill))

wal_pi<-read.table("walpole_resistant.sites.pi",header=T)
wal_pibycopy<-inner_join(wal_pi,res_wal_var, by="POS")
lm1<-lm(data=wal_pibycopy,Median~PI)
summary(lm1)

wal_pi_S<-read.table("walpole_susceptible.sites.pi",header=T)
wal_pibycopy_S<-inner_join(wal_pi_S,sus_wal_var, by="POS")
lm2<-lm(data=wal_pibycopy_S,Median~PI)
summary(lm2)

library(ggplot2)

ggplot(data=wal_pibycopy,aes(PI,Median))+
  geom_point(alpha=.3) +
  geom_abline(intercept=lm1$coefficients[1],slope=lm1$coefficients[2])

essex_pi<-read.table("essex_resistant.sites.pi",header=T)
essex_pibycopy<-inner_join(essex_pi,res_ess_var, by="POS")
lm3<-lm(data=essex_pibycopy,Median~PI)
summary(lm3)

essex_pi_S<-read.table("essex_susceptible.sites.pi",header=T)
essex_pibycopy_S<-inner_join(essex_pi_S,sus_ess_var, by="POS")
lm3<-lm(data=essex_pibycopy_S,Median~PI)
summary(lm3)


#plot variances
p1<-ggplot() +
  geom_point(data=res_wal_var,aes(Position,Variance),color="goldenrod",alpha=.05,cex=.5) +
  geom_point(data=sus_wal_var,aes(Position,Variance),color="darkslategray4",alpha=.05,cex=.5) +
  theme_bw() +
  ylim(0,2000) +
  ylab("Variance in Copy Number") +
  geom_vline(xintercept = 412731,linetype = 2, aes(colour="black"),size=1,alpha=.7) +
  geom_vline(xintercept = 401724, linetype = 2, aes(colour="black"),size=1,alpha=.7) 

p3<-ggplot() +
  geom_point(data=res_ess_var,aes(Position,Variance),color="goldenrod",alpha=.05,cex=.5) +
  geom_point(data=sus_ess_var,aes(Position,Variance),color="darkslategray4",alpha=.05,cex=.5) +
  theme_bw() +
  ylab("") +
  ylim(0,100) +
  geom_vline(xintercept = 412731,linetype = 2, aes(colour="black"),size=.5,alpha=.7) +
  geom_vline(xintercept = 401724, linetype = 2, aes(colour="black"),size=.5,alpha=.7) 


p5<-ggplot() +
  geom_point(data=res_ill_var,aes(Position,Variance),color="goldenrod",alpha=.05,cex=.5) +
  geom_point(data=sus_ill_var,aes(Position,Variance),color="darkslategray4",alpha=.05,cex=.5) +
  theme_bw() +
  ylab("") +
  ylim(0,1000) +
  geom_vline(xintercept = 412731,linetype = 2, aes(colour="black"),size=.5,alpha=.7) +
  geom_vline(xintercept = 401724, linetype = 2, aes(colour="black"),size=.5,alpha=.7) 

#plot medians

p2<-ggplot() +
  geom_point(data=res_wal_var,aes(Position,Median),color="goldenrod",alpha=.05,cex=.5) +
  geom_point(data=sus_wal_var,aes(Position,Median),color="darkslategray4",alpha=.05,cex=.5) +
  theme_bw() +
  ylab("Median Copy Number") +
  xlab("") +
  ggtitle("Walpole") +
  ylim(0,40) +
  geom_vline(xintercept = 412731,linetype = 2, aes(colour="black"),size=.5,alpha=.7) +
  geom_vline(xintercept = 401724, linetype = 2, aes(colour="black"),size=.5,alpha=.7) 

p4<-ggplot() +
  geom_point(data=res_ess_var,aes(Position,Median),color="goldenrod",alpha=.05,cex=.5) +
  geom_point(data=sus_ess_var,aes(Position,Median),color="darkslategray4",alpha=.05,cex=.5) +
  theme_bw() +
  ylab("") +
  xlab("") +
  ylim(0,40) +
  ggtitle("Essex") +
  geom_vline(xintercept = 412731,linetype = 2, aes(colour="black"),size=.5,alpha=.7) +
  geom_vline(xintercept = 401724, linetype = 2, aes(colour="black"),size=.5,alpha=.7) 

p6<-ggplot() +
  geom_point(data=res_ill_var,aes(Position,Median),color="goldenrod",alpha=.05,cex=.5) +
  geom_point(data=sus_ill_var,aes(Position,Median),color="darkslategray4",alpha=.05,cex=.5) +
  theme_bw() +
  ylab("") +
  xlab("") +
  ylim(0,40) +
  ggtitle("Midwest") +
  geom_vline(xintercept = 412731,linetype = 2, aes(colour="black"),size=.5,alpha=.7) +
  geom_vline(xintercept = 401724, linetype = 2, aes(colour="black"),size=.5,alpha=.7) 


library(gridExtra)
library(ggplot2)
#install.packages("cowplot")
library(cowplot)

plot_grid(p2, p4, p6, 
          p1, p3, p5, 
          align = "h", 
          nrow = 2)


longcov<-melt(epsps,id='pos') #change to long format data
names(longcov)<-c("pos","ind","cov")



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


p1<-ggplot(longcov2, aes(x=pos,y=ind, height=cov,fill=cov)) +
  geom_density_ridges_gradient(stat="identity",scale=1,size=0.02, panel_scaling = F) +
  #geom_vline(xintercept = 402219, alpha.4) +
  #geom_vline(xintercept = 402460, alpha=.7) +
  #geom_vline(xintercept = 404190, alpha=.7) +
  #geom_vline(xintercept = 404712, alpha=.7) +
  #geom_vline(xintercept = 404957, alpha=.7) +
  #geom_vline(xintercept = 406608, alpha=.7) +
  #geom_vline(xintercept = 409504, alpha=.7) +
  #geom_vline(xintercept = 412245, alpha=.7) +
  geom_vline(xintercept = 412731,linetype = 2, aes(colour="#c1c1c1"),size=.5,alpha=.7) +
  geom_vline(xintercept = 401724, linetype = 2, aes(colour="#c1c1c1"),size=.5,alpha=.7) +
  scale_fill_viridis(discrete=F, direction = -1, name="Copy Number \n",limits=c(0,160),guide=F) +
  theme_ridges() +
  ggtitle("Walpole")


#plot essex
epsps3<-resistant[,c(1,28:53)]
longcov3<-melt(epsps3,id='pos') #change to long format data
names(longcov3)<-c("pos","ind","cov")

p2<-ggplot(longcov3, aes(x=pos,y=ind, height=cov,fill=cov)) +
  geom_density_ridges_gradient(stat="identity",scale=1,size=.02) +
  #geom_vline(xintercept = 402219) +
  #geom_vline(xintercept = 402460) +
  #geom_vline(xintercept = 404190) +
  #geom_vline(xintercept = 404712) +
  #geom_vline(xintercept = 404957) +
  #geom_vline(xintercept = 406608) +
  #geom_vline(xintercept = 409504) +
  #geom_vline(xintercept = 412245) +
  geom_vline(xintercept = 412731,linetype = 2, aes(colour="#c1c1c1"),size=.7) +
  geom_vline(xintercept = 401724, linetype = 2, aes(colour="#c1c1c1"),size=.7) +
  scale_fill_viridis(discrete = F, direction = -1, name="Copy Number \n",limits=c(0,160),guide=F) +
  theme_ridges() +
  ggtitle("Essex")

#plot illinois
epsps4<-resistant[,c(1,54:91)]
longcov4<-melt(epsps4,id='pos') #change to long format data
names(longcov4)<-c("pos","ind","cov")

p3<-ggplot(longcov4, aes(x=pos,y=ind, height=cov,fill=cov)) +
  geom_density_ridges_gradient(stat="identity",scale=1,size=.02)  +
  #geom_vline(xintercept = 402219) +
  #geom_vline(xintercept = 402460) +
  #geom_vline(xintercept = 404190) +
  #geom_vline(xintercept = 404712) +
  #geom_vline(xintercept = 404957) +
  #geom_vline(xintercept = 406608) +
  #geom_vline(xintercept = 409504) +
  #geom_vline(xintercept = 412245) +
  geom_vline(xintercept = 412731,linetype = 2, aes(colour="#c1c1c1"),size=.7) +
  geom_vline(xintercept = 401724, linetype = 2, aes(colour="#c1c1c1"),size=.7) +
  scale_fill_viridis(discrete = F, direction = -1, name="Copy Number \n",limits=c(0,160),guide=F) +
  theme_ridges() +
  ggtitle("Illinois")




library(gridExtra)
library(ggplot2)
install.packages("cowplot")
library(cowplot)
plot_grid(p1, p2, p3, align = "h", nrow = 1, rel_widths = c(1/3, 1/3, 1/3),labels = c('A', 'B','C'))

grid.arrange(p1, p2, p3, nrow = 1,widths=c(1,1,1))

#plot nat
epsps5<-epsps[,c(1,157:166)]
longcov5<-melt(epsps5,id='pos') #change to long format data
names(longcov5)<-c("pos","ind","cov")

ggplot(longcov5, aes(x=pos,y=ind, height=cov,fill=cov)) +
  geom_density_ridges_gradient(stat="identity",scale=1,size=.05)  +
  #geom_vline(xintercept = 402219) +
  #geom_vline(xintercept = 402460) +
  #geom_vline(xintercept = 404190) +
  #geom_vline(xintercept = 404712) +
  #geom_vline(xintercept = 404957) +
  #geom_vline(xintercept = 406608) +
  #geom_vline(xintercept = 409504) +
  #geom_vline(xintercept = 412245) +
  geom_vline(xintercept = 412731,linetype = 2, aes(colour="#c1c1c1"),size=.7) +
  geom_vline(xintercept = 401724, linetype = 2, aes(colour="#c1c1c1"),size=.7) +
  scale_fill_viridis(discrete = F, direction = -1) +
  theme_ridges() +
  guides(fill=guide_legend(title="Copy Number")) +
  ggtitle("Natural Pops")



mean(longcov$meancov)
median(longcov$meancov)
