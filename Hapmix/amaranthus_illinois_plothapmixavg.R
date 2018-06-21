#amaranthus plot hapmix


ILL1<-read.table("ILL_MISSOU.LOCALANC.0.HTG_893")
ILL2<-read.table("ILL_MISSOU.LOCALANC.1.HTG_893")
ILL3<-read.table("ILL_MISSOU.LOCALANC.2.HTG_893")
ILL4<-read.table("ILL_MISSOU.LOCALANC.3.HTG_893")
ILL5<-read.table("ILL_MISSOU.LOCALANC.4.HTG_893")
ILL6<-read.table("ILL_MISSOU.LOCALANC.5.HTG_893")
ILL7<-read.table("ILL_MISSOU.LOCALANC.6.HTG_893")
ILL8<-read.table("ILL_MISSOU.LOCALANC.7.HTG_893")
ILL9<-read.table("ILL_MISSOU.LOCALANC.8.HTG_893")
ILL10<-read.table("ILL_MISSOU.LOCALANC.9.HTG_893")
ILL11<-read.table("ILL_MISSOU.LOCALANC.10.HTG_893")
ILL12<-read.table("ILL_MISSOU.LOCALANC.11.HTG_893")
ILL13<-read.table("ILL_MISSOU.LOCALANC.12.HTG_893")
ILL14<-read.table("ILL_MISSOU.LOCALANC.13.HTG_893")
ILL15<-read.table("ILL_MISSOU.LOCALANC.14.HTG_893")
ILL16<-read.table("ILL_MISSOU.LOCALANC.15.HTG_893")
ILL17<-read.table("ILL_MISSOU.LOCALANC.16.HTG_893")
ILL18<-read.table("ILL_MISSOU.LOCALANC.17.HTG_893")
ILL19<-read.table("ILL_MISSOU.LOCALANC.18.HTG_893")
ILL20<-read.table("ILL_MISSOU.LOCALANC.19.HTG_893")
ILL21<-read.table("ILL_MISSOU.LOCALANC.20.HTG_893")
ILL22<-read.table("ILL_MISSOU.LOCALANC.21.HTG_893")
ILL23<-read.table("ILL_MISSOU.LOCALANC.22.HTG_893")
ILL24<-read.table("ILL_MISSOU.LOCALANC.23.HTG_893")
ILL25<-read.table("ILL_MISSOU.LOCALANC.24.HTG_893")
ILL26<-read.table("ILL_MISSOU.LOCALANC.25.HTG_893")
ILL27<-read.table("ILL_MISSOU.LOCALANC.26.HTG_893")
ILL28<-read.table("ILL_MISSOU.LOCALANC.27.HTG_893")
ILL29<-read.table("ILL_MISSOU.LOCALANC.28.HTG_893")
ILL30<-read.table("ILL_MISSOU.LOCALANC.29.HTG_893")
ILL31<-read.table("ILL_MISSOU.LOCALANC.30.HTG_893")
ILL32<-read.table("ILL_MISSOU.LOCALANC.31.HTG_893")
ILL33<-read.table("ILL_MISSOU.LOCALANC.32.HTG_893")
ILL34<-read.table("ILL_MISSOU.LOCALANC.33.HTG_893")
ILL35<-read.table("ILL_MISSOU.LOCALANC.34.HTG_893")
ILL36<-read.table("ILL_MISSOU.LOCALANC.35.HTG_893")
ILL37<-read.table("ILL_MISSOU.LOCALANC.36.HTG_893")
ILL38<-read.table("ILL_MISSOU.LOCALANC.37.HTG_893")
ILL39<-read.table("ILL_MISSOU.LOCALANC.38.HTG_893")
ILL40<-read.table("ILL_MISSOU.LOCALANC.29.HTG_893")
ILL41<-read.table("ILL_MISSOU.LOCALANC.40.HTG_893")
ILL42<-read.table("ILL_MISSOU.LOCALANC.41.HTG_893")
ILL43<-read.table("ILL_MISSOU.LOCALANC.42.HTG_893")
ILL44<-read.table("ILL_MISSOU.LOCALANC.43.HTG_893")
ILL45<-read.table("ILL_MISSOU.LOCALANC.44.HTG_893")
ILL46<-read.table("ILL_MISSOU.LOCALANC.45.HTG_893")
ILL47<-read.table("ILL_MISSOU.LOCALANC.46.HTG_893")
ILL48<-read.table("ILL_MISSOU.LOCALANC.47.HTG_893")
ILL49<-read.table("ILL_MISSOU.LOCALANC.48.HTG_893")
ILL50<-read.table("ILL_MISSOU.LOCALANC.49.HTG_893")
ILL51<-read.table("ILL_MISSOU.LOCALANC.50.HTG_893")
ILL52<-read.table("ILL_MISSOU.LOCALANC.51.HTG_893")
ILL53<-read.table("ILL_MISSOU.LOCALANC.52.HTG_893")


colnames(ILL1)<-c("two","one","zero")
colnames(ILL2)<-c("two","one","zero")
colnames(ILL3)<-c("two","one","zero")
colnames(ILL4)<-c("two","one","zero")
colnames(ILL5)<-c("two","one","zero")
colnames(ILL6)<-c("two","one","zero")
colnames(ILL7)<-c("two","one","zero")
colnames(ILL8)<-c("two","one","zero")
colnames(ILL9)<-c("two","one","zero")
colnames(ILL10)<-c("two","one","zero")
colnames(ILL11)<-c("two","one","zero")
colnames(ILL12)<-c("two","one","zero")
colnames(ILL13)<-c("two","one","zero")
colnames(ILL14)<-c("two","one","zero")
colnames(ILL15)<-c("two","one","zero")
colnames(ILL16)<-c("two","one","zero")
colnames(ILL17)<-c("two","one","zero")
colnames(ILL18)<-c("two","one","zero")
colnames(ILL19)<-c("two","one","zero")
colnames(ILL20)<-c("two","one","zero")
colnames(ILL21)<-c("two","one","zero")
colnames(ILL22)<-c("two","one","zero")
colnames(ILL23)<-c("two","one","zero")
colnames(ILL24)<-c("two","one","zero")
colnames(ILL25)<-c("two","one","zero")
colnames(ILL26)<-c("two","one","zero")
colnames(ILL27)<-c("two","one","zero")
colnames(ILL28)<-c("two","one","zero")
colnames(ILL29)<-c("two","one","zero")
colnames(ILL30)<-c("two","one","zero")
colnames(ILL31)<-c("two","one","zero")
colnames(ILL32)<-c("two","one","zero")
colnames(ILL33)<-c("two","one","zero")
colnames(ILL34)<-c("two","one","zero")
colnames(ILL35)<-c("two","one","zero")
colnames(ILL36)<-c("two","one","zero")
colnames(ILL37)<-c("two","one","zero")
colnames(ILL38)<-c("two","one","zero")
colnames(ILL39)<-c("two","one","zero")
colnames(ILL40)<-c("two","one","zero")
colnames(ILL41)<-c("two","one","zero")
colnames(ILL42)<-c("two","one","zero")
colnames(ILL43)<-c("two","one","zero")
colnames(ILL44)<-c("two","one","zero")
colnames(ILL45)<-c("two","one","zero")
colnames(ILL46)<-c("two","one","zero")
colnames(ILL47)<-c("two","one","zero")
colnames(ILL48)<-c("two","one","zero")
colnames(ILL49)<-c("two","one","zero")
colnames(ILL50)<-c("two","one","zero")
colnames(ILL51)<-c("two","one","zero")
colnames(ILL52)<-c("two","one","zero")
colnames(ILL53)<-c("two","one","zero")

introgressed1<-(2*ILL1$two) + ILL1$one
introgressed2<-(2*ILL2$two) + ILL2$one
introgressed3<-(2*ILL3$two) + ILL3$one
introgressed4<-(2*ILL4$two) + ILL4$one
introgressed5<-(2*ILL5$two) + ILL5$one
introgressed6<-(2*ILL6$two) + ILL6$one
introgressed7<-(2*ILL7$two) + ILL7$one
introgressed8<-(2*ILL8$two) + ILL8$one
introgressed9<-(2*ILL9$two) + ILL9$one
introgressed10<-(2*ILL10$two) + ILL10$one
introgressed11<-(2*ILL11$two) + ILL11$one
introgressed12<-(2*ILL12$two) + ILL12$one
introgressed13<-(2*ILL13$two) + ILL13$one
introgressed14<-(2*ILL14$two) + ILL14$one
introgressed15<-(2*ILL15$two) + ILL15$one
introgressed16<-(2*ILL16$two) + ILL16$one
introgressed17<-(2*ILL17$two) + ILL17$one
introgressed18<-(2*ILL18$two) + ILL18$one
introgressed19<-(2*ILL19$two) + ILL19$one
introgressed20<-(2*ILL20$two) + ILL20$one
introgressed21<-(2*ILL21$two) + ILL21$one
introgressed22<-(2*ILL22$two) + ILL22$one
introgressed23<-(2*ILL23$two) + ILL23$one
introgressed24<-(2*ILL24$two) + ILL24$one
introgressed25<-(2*ILL25$two) + ILL25$one
introgressed26<-(2*ILL26$two) + ILL26$one
introgressed27<-(2*ILL27$two) + ILL27$one
introgressed28<-(2*ILL28$two) + ILL28$one
introgressed29<-(2*ILL29$two) + ILL29$one
introgressed30<-(2*ILL30$two) + ILL30$one
introgressed31<-(2*ILL31$two) + ILL31$one
introgressed32<-(2*ILL32$two) + ILL32$one
introgressed33<-(2*ILL33$two) + ILL33$one
introgressed34<-(2*ILL34$two) + ILL34$one
introgressed35<-(2*ILL35$two) + ILL35$one
introgressed36<-(2*ILL36$two) + ILL36$one
introgressed37<-(2*ILL37$two) + ILL37$one
introgressed38<-(2*ILL38$two) + ILL38$one
introgressed39<-(2*ILL39$two) + ILL39$one
introgressed40<-(2*ILL40$two) + ILL40$one
introgressed41<-(2*ILL41$two) + ILL41$one
introgressed42<-(2*ILL42$two) + ILL42$one
introgressed43<-(2*ILL43$two) + ILL43$one
introgressed44<-(2*ILL44$two) + ILL44$one
introgressed45<-(2*ILL45$two) + ILL45$one
introgressed46<-(2*ILL46$two) + ILL46$one
introgressed47<-(2*ILL47$two) + ILL47$one
introgressed48<-(2*ILL48$two) + ILL48$one
introgressed49<-(2*ILL49$two) + ILL49$one
introgressed50<-(2*ILL50$two) + ILL50$one
introgressed51<-(2*ILL51$two) + ILL51$one
introgressed52<-(2*ILL52$two) + ILL52$one
introgressed53<-(2*ILL53$two) + ILL53$one

nointro1<-(2*ILL1$zero) + ILL1$one
nointro2<-(2*ILL2$zero) + ILL2$one
nointro3<-(2*ILL3$zero) + ILL3$one
nointro4<-(2*ILL4$zero) + ILL4$one
nointro5<-(2*ILL5$zero) + ILL5$one
nointro6<-(2*ILL6$zero) + ILL6$one
nointro7<-(2*ILL7$zero) + ILL7$one
nointro8<-(2*ILL8$zero) + ILL8$one
nointro9<-(2*ILL9$zero) + ILL9$one
nointro10<-(2*ILL10$zero) + ILL10$one
nointro11<-(2*ILL11$zero) + ILL11$one
nointro12<-(2*ILL12$zero) + ILL12$one
nointro13<-(2*ILL13$zero) + ILL13$one
nointro14<-(2*ILL14$zero) + ILL14$one
nointro15<-(2*ILL15$zero) + ILL15$one
nointro16<-(2*ILL16$zero) + ILL16$one
nointro17<-(2*ILL17$zero) + ILL17$one
nointro18<-(2*ILL18$zero) + ILL18$one
nointro19<-(2*ILL19$zero) + ILL19$one
nointro20<-(2*ILL20$zero) + ILL20$one
nointro21<-(2*ILL21$zero) + ILL21$one
nointro22<-(2*ILL22$zero) + ILL22$one
nointro23<-(2*ILL23$zero) + ILL23$one
nointro24<-(2*ILL24$zero) + ILL24$one
nointro25<-(2*ILL25$zero) + ILL25$one
nointro26<-(2*ILL26$zero) + ILL26$one
nointro27<-(2*ILL27$zero) + ILL27$one
nointro28<-(2*ILL28$zero) + ILL28$one
nointro29<-(2*ILL29$zero) + ILL29$one
nointro30<-(2*ILL30$zero) + ILL30$one
nointro31<-(2*ILL31$zero) + ILL31$one
nointro32<-(2*ILL32$zero) + ILL32$one
nointro33<-(2*ILL33$zero) + ILL33$one
nointro34<-(2*ILL34$zero) + ILL34$one
nointro35<-(2*ILL35$zero) + ILL35$one
nointro36<-(2*ILL36$zero) + ILL36$one
nointro37<-(2*ILL37$zero) + ILL37$one
nointro38<-(2*ILL38$zero) + ILL38$one
nointro39<-(2*ILL39$zero) + ILL39$one
nointro40<-(2*ILL40$zero) + ILL40$one
nointro41<-(2*ILL41$zero) + ILL41$one
nointro42<-(2*ILL42$zero) + ILL42$one
nointro43<-(2*ILL43$zero) + ILL43$one
nointro44<-(2*ILL44$zero) + ILL44$one
nointro45<-(2*ILL45$zero) + ILL45$one
nointro46<-(2*ILL46$zero) + ILL46$one
nointro47<-(2*ILL47$zero) + ILL47$one
nointro48<-(2*ILL48$zero) + ILL48$one
nointro49<-(2*ILL49$zero) + ILL49$one
nointro50<-(2*ILL50$zero) + ILL50$one
nointro51<-(2*ILL51$zero) + ILL51$one
nointro52<-(2*ILL52$zero) + ILL52$one
nointro53<-(2*ILL53$zero) + ILL53$one


avg_intro<- (introgressed1 + introgressed2 + introgressed3 + introgressed4 + introgressed5 + introgressed6 + introgressed7 + introgressed8 + introgressed9 + introgressed10 + introgressed11
             + introgressed12+ introgressed13+ introgressed14+ introgressed15+ introgressed16+ introgressed17+ introgressed18+ introgressed19+ introgressed20
             + introgressed21+ introgressed22+ introgressed23+ introgressed24+ introgressed25+ introgressed26+ introgressed27+ introgressed28+ introgressed29+ introgressed30
             + introgressed31+ introgressed32+ introgressed33+ introgressed34+ introgressed35+ introgressed36+ introgressed37+ introgressed38+ introgressed39+ introgressed40+ introgressed41+ introgressed42
             + introgressed43+ introgressed44+ introgressed45+ introgressed46+ introgressed47+ introgressed48+ introgressed49+ introgressed50+ introgressed51+ introgressed52 + introgressed53)/53

avg_nonintro<- (nointro1 + nointro2 + nointro3 + nointro4 + nointro5 + nointro6 + nointro7 + nointro8 + nointro9 + nointro10 + nointro11
                + nointro12+ nointro13+ nointro14+ nointro15+ nointro16+ nointro17+ nointro18+ nointro19+ nointro20
                + nointro21+ nointro22+ nointro23+ nointro24+ nointro25+ nointro26+ nointro27+ nointro28+ nointro29+ nointro30
                + nointro31+ nointro32+ nointro33+ nointro34+ nointro35+ nointro36+ nointro37+ nointro38+ nointro39+ nointro40+ nointro41+ nointro42
                + nointro43+ nointro44+ nointro45+ nointro46+ nointro47+ nointro48+ nointro49+ nointro50+ nointro51+ nointro52 + nointro53)/53

par(mfrow=c(1,1))

chrm1avgs<-data.frame(avg_intro=avg_intro,avg_nonintro=avg_nonintro, pos=essex$POS, scaf="HTG_893", stringsAsFactors=FALSE)
barplot(t(chrm1avgs[,2:1]), col=c("darkcyan","orange"), border=NA, space=0, 
        main = "Illinois Admixed ancestry relative to Natural Pops (Green) and Missouri (Orange)",yaxt='n', ann=FALSE)

#barplot(t(chrm1avgs[,1]), col=c("darkcyan","orange"), border=NA, space=0, 
        main = "Illinois ancestry relative to Natural Pops (Green) and Essex (Orange)",yaxt='n', ann=FALSE)


abline(v = min(which(chrm1avgs$pos > 401724)),lty=2,col="gray10",lwd=2)
abline(v = max(which(chrm1avgs$pos < 412731 )) ,lty=2,col="gray10",lwd=2)
#chrm1_noncentro<-chrm1avgs[which(chrm1avgs$pos < 10000000 | chrm1avgs$pos > 19598040),]

lab2<-c()
lab2<-c(essex$POS[1])
for (i in 1:10) {
  lab2<-c(lab2,essex$POS[(length(essex$POS)/10)*i])
}

at2<-c()
at2<-c(1)
for (i in 1:10) {
  at2<-c(at2,(length(essex$POS)/10)*i)
}
axis(side=1,at=at2, labels = lab2,cex.axis=.75,las=2)
