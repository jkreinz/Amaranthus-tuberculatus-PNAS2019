# install dependencies and devtools
install.packages(c("Cairo","ggplot2","gridExtra","gtable","tidyr","devtools"),dependencies=T)

# install pophelper package from GitHub
devtools::install_github('royfrancis/pophelper')

# load library for use
library(pophelper)
sfiles <- "allpops_logistic.3.meanQ"
sfiles[2] <- "allpops_logistic.4.meanQ"
sfiles[3] <- "allpops_logistic.5.meanQ"
sfiles[4] <- "allpops_logistic.6.meanQ"

slist <- readQ(files=sfiles)


inds <- read.table("indmap.txt")
if(length(unique(sapply(slist,nrow)))==1) slist <- lapply(slist,"rownames<-",inds$V1)

group<-read.table("popmap.txt")
group$V1<-as.character(group$V1)
group2<-read.table("popmaps3.txt")
group$V2<-as.character(group2$V1)
names(group)<-c("Region","Pop")

library(wesanderson)
pal<-wes_palette("Darjeeling1",5,type="discrete")
pal2<-c("#FF0000","#00A08A","#F2AD00", "#5BBCD6","#F98400","#3b6c93")
        
        #"#923a6f","#2B537A")
pal3<-c("#FF0000","#00A08A","#F2AD00")


#plot sorted, west to east
plotQ(slist[1:4],imgoutput="join",showindlab=F,grplab=group,
      ordergrp=T,showlegend=F,useindlab=T,grplabsize = 4,sppos = 'left',
      showtitle=F,showsubtitle=F,divsize = 1,splabsize = 10,
      height=2,width=25,indlabheight=0.4,indlabspacer=5,
      splab=c("K=3","K=4","K=5","K=6"),selgrp = "Pop",divgrp="Region",
      subsetgrp=c("K","D","B","H","E","F","G","J","4","5","7","6","9","17","16","18","27","19","15","N1","N3","N4"), 
      barbordercolour="white",barbordersize=0,outputfilename="ontario_illinois_missouri_struc_logistic_K3-8_smaller",imgtype="pdf",
      clustercol = pal2)

plotQ(slist[1:2],imgoutput="join",showindlab=F,grplab=group,
      ordergrp=T,showlegend=F,useindlab=T,grplabsize = 4,sppos = 'left',
      showtitle=F,showsubtitle=F,divsize = 1,splabsize = 10,
      height=3,width=40,indlabheight=0.4,indlabspacer=5,
      splab=c("K=2","K=3"),selgrp = "Pop",divgrp="Region",
      subsetgrp=c("K","D","B","H","E","F","G","J","4","5","7","6","9","17","16","18","27","19","15","N1","N3","N4"), 
      barbordercolour="white",barbordersize=0,outputfilename="ontario_illinois_missouri_struc_simple_smaller",imgtype="pdf",
      clustercol = pal3)

sr1 <- summariseQ(tabulateQ(slist))
p <- evannoMethodStructure(data=sr1,exportplot=F,returnplot=T,returndata=F,basesize=12,linesize=0.7)
grid.arrange(p)


#plot unsorted, no labels
#plot sorted
plotQ(slist[1:4],imgoutput="join",showindlab=T,grplab=group,
      ordergrp=T,showlegend=F,useindlab=T,grplabsize = 4,sppos = 'left',
      showtitle=F,showsubtitle=F,divsize = 1.0,splabsize = 10, sortind="all", sharedindlab = F,
      height=3,width=20,indlabsize=4,indlabheight=0.4,indlabspacer=5,
      splab=c("K=2","K=3","K=4","K=5"), subsetgrp=c("Illinois","Essex_County","Walpole_Island","Natural_Ontario"),
      barbordercolour="white",barbordersize=0,outputfilename="ontario_illinois_sortedstruc_K2-5",imgtype="pdf",
      clustercol = pal2)


slist[1]
