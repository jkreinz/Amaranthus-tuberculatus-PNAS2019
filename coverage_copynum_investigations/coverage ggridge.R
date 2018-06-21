library(data.table)
cov<-fread("illinois_depth_allsites.txt") #output from vcftools genotype coverage

windowedcov<- cov %>% mutate(WIN=floor(POS/10000)) %>% group_by(CHROM,WIN) %>% summarise(`15_10`=mean(`15_10`), `15_11`=mean(`15_11`), `15_3`=mean(`15_3`), `15_5`=mean(`15_5`), `15_6`=mean(`15_6`), `15_7`=mean(`15_7`), `16_1`=mean(`16_1`), `16_2`=mean(`16_2`), `16_3`=mean(`16_3`), `16_5`=mean(`16_5`), `16_6`=mean(`16_6`), `16_7`=mean(`16_7`), `16_8`=mean(`16_8`), `16_9`=mean(`16_9`), `17_10`=mean(`17_10`), `17_11`=mean(`17_11`), `17_1`=mean(`17_1`), `17_3`=mean(`17_3`), `17_4`=mean(`17_4`), `17_6`=mean(`17_6`), `17_7`=mean(`17_7`), `17_9`=mean(`17_9`), `18_11`=mean(`18_11`), `18_15`=mean(`18_15`), `18_16`=mean(`18_16`), `18_1`=mean(`18_1`), `18_2`=mean(`18_2`), `18_3`=mean(`18_3`), `19_1_1`=mean(`19_1_1`), `19_1_3`=mean(`19_1_3`), `19_3`=mean(`19_3`), `19_4`=mean(`19_4`), `19_5`=mean(`19_5`), `19_6`=mean(`19_6`), `27_10`=mean(`27_10`), `27_2`=mean(`27_2`), `27_3`=mean(`27_3`), `27_4`=mean(`27_4`), `27_5`=mean(`27_5`), `27_6`=mean(`27_6`), `27_8`=mean(`27_8`), `27_9`=mean(`27_9`), `4_11`=mean(`4_11`), `4_12`=mean(`4_12`), `4_13`=mean(`4_13`), `4_16`=mean(`4_16`), `4_18`=mean(`4_18`), `4_1`=mean(`4_1`), `4_2`=mean(`4_2`), `4_8`=mean(`4_8`), `4_9`=mean(`4_9`), `5_10`=mean(`5_10`), `5_15`=mean(`5_15`), `5_19`=mean(`5_19`), `5_2`=mean(`5_2`), `5_4`=mean(`5_4`), `5_7`=mean(`5_7`), `5_8`=mean(`5_8`), `6_10`=mean(`6_10`), `6_2`=mean(`6_2`), `6_3`=mean(`6_3`), `6_5`=mean(`6_5`), `6_6`=mean(`6_6`), `6_7`=mean(`6_7`), `6_9`=mean(`6_9`), `7_10`=mean(`7_10`), `7_12`=mean(`7_12`), `7_14`=mean(`7_14`), `7_2`=mean(`7_2`), `7_5`=mean(`7_5`), `7_7`=mean(`7_7`), `9_10`=mean(`9_10`), `9_11`=mean(`9_11`), `9_1`=mean(`9_1`), `9_4`=mean(`9_4`), `9_5`=mean(`9_5`), `9_6`=mean(`9_6`), `9_7`=mean(`9_7`), `9_9`=mean(`9_9`), `N1_1`=mean(`N1_1`), `N1_2`=mean(`N1_2`), `N1_3`=mean(`N1_3`), `N1_5`=mean(`N1_5`), `N1_6`=mean(`N1_6`), `N3_1`=mean(`N3_1`), `N3_2`=mean(`N3_2`), `N3_3`=mean(`N3_3`), `N4_2`=mean(`N4_2`), `N4_3`=mean(`N4_3`))
wind2<-subset(windowedcov,select=-c(CHROM,WIN))


lowerq <- list()
for (i in names(wind2)) {
  # using as.names not needed and possibly harmful
  lowerq[i]<-quantile(wind2[[i]])[2]
}

upperq <- list()
for (i in names(wind2)) {
  # using as.names not needed and possibly harmful
  upperq[i]<-quantile(wind2[[i]])[4]
}

iqr <- list()
for (i in names(wind2)) {
  # using as.names not needed and possibly harmful
  iqr[i]<-IQR(wind2[[i]])
}

quarts<-data.frame(matrix(nrow=89,ncol=5))
quarts$upper<-unlist(upperq)
.
.
.

p$mild.threshold.upper = rbind(p$mild.threshold.upper, (iqr * 1.5) + upperq)
p$mild.threshold.lower = rbind(p$mild.threshold.lower, lowerq - (iqr * 1.5))

quarts<-data.frame(matrix(nrow=89,ncol=5))
quarts$lowerq<-unlist(lowerq)
quarts$upperq<-unlist(upperq)
quarts$iqr<-unlist(iqr)
quarts$mild.threshold.upper<-(quarts$iqr * 1.5) + quarts$upperq
quarts$mild.threshold.lower<- quarts$lowerq - (quarts$iqr * 1.5)
quarts$extreme.threshold.upper<-(quarts$iqr * 3) + quarts$upperq
quarts$extreme.threshold.lower<- quarts$lowerq - (quarts$iqr *3)


longcov<-melt(cov) #change to long format data
names(longcov)<-c("individual","meancov")

install.packages("ggridges")
library(ggridges)
library(ggplot2)
install.packages("devtools")
library(devtools)
install.packages("wesanderson")
library("wesanderson")
names(wes_palettes)


#plot ggridge
ggplot(longcov, aes(x = meancov, y = individual,height=..density..,fill=individual)) +
  geom_density_ridges(scale=4,alpha=.7) +
  xlim(0,100) +
  scale_y_discrete(expand = c(0.05, 0)) +
  scale_fill_cyclical(values=wes_palette("Zissou")) +
  theme_ridges(font_size = 8, grid = TRUE,center_axis_labels = T) +
  xlab("Mean Coverage in 10KB Windows") +
  ylab("Individual") +
  ggtitle("Illinois depth, all sites")

mean(longcov$meancov)
median(longcov$meancov)

