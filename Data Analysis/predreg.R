#Clean testArea

install.packages('xts')
library(xts)
options(scipen=999)  # turn off scientific notation like 1e+06
library(ggplot2)
install.packages('reshape')
library(reshape)
install.packages('tidyr')
library(tidyr)
install.packages('ggfortify')
library(ggfortify)




testArea2 <- testArea
testArea2$X1 <- NULL
testArea2$sample.samplingPoint <- NULL
testArea2$sample.samplingPoint.notation <- NULL
testArea2$sample.samplingPoint.label <- NULL
testArea2$determinand.label <- NULL
testArea2$determinand.definition <- NULL
testArea2$determinand.notation <- NULL
testArea2$resultQualifier.notation <- NULL
testArea2$codedResultInterpretation.interpretation <- NULL
#testArea2$@id <- NULL
testArea2$X1 <- NULL
testArea2$X1 <- NULL
testArea2$determinand.unit.label <- NULL
testArea2$sample.sampledMaterialType.label <- NULL
  
keeps <- c("sample.sampleDateTime", "result")
keeps <- c("Date","Result")
testArea2 <- testArea[keeps]
testArea2[testArea2 == 0] <- NA



testArea2$sample.sampleDateTime <- as.Date(testArea2$sample.sampleDateTime)
hw <- HoltWinters(ts1)

tA <- ts(testArea2)
ts <- ts(df, frequency=365)

write.csv(ts, 'tmp.csv')


forecast <- predict(hw, n.ahead = 365, prediction.interval = T, level = 0.95)
plot(hw, forecast)


autoplot(ts)

testArea2$sample.sampleDateTime <- format(as.POSIXct(testArea2$sample.sampleDateTime,format='%m/%d/%Y %H:%M:%S'),format='%m/%d/%Y')
ts <- ts(testArea2)


stocks <- xts(df[,-1], order.by=as.Date(df[,1], "%m/%d/%Y"))


complete(testArea2 = seq.Date(min(testArea), max(testArea), by="day"))


HWplot<-function(ts_object,  n.ahead=4,  CI=.95,  error.ribbon='green', line.size=1){
  
  hw_object<-HoltWinters(ts_object)
  
  forecast<-predict(hw_object,  n.ahead=n.ahead,  prediction.interval=T,  level=CI)
  
  
  for_values<-data.frame(time=round(time(forecast),  3),  value_forecast=as.data.frame(forecast)$fit,  dev=as.data.frame(forecast)$upr-as.data.frame(forecast)$fit)
  
  fitted_values<-data.frame(time=round(time(hw_object$fitted),  3),  value_fitted=as.data.frame(hw_object$fitted)$xhat)
  
  actual_values<-data.frame(time=round(time(hw_object$x),  3),  Actual=c(hw_object$x))
  
  
  graphset<-merge(actual_values,  fitted_values,  by='time',  all=TRUE)
  graphset<-merge(graphset,  for_values,  all=TRUE,  by='time')
  graphset[is.na(graphset$dev),  ]$dev<-0
  
  graphset$Fitted<-c(rep(NA,  NROW(graphset)-(NROW(for_values) + NROW(fitted_values))),  fitted_values$value_fitted,  for_values$value_forecast)
  
  
  graphset.melt<-melt(graphset[, c('time', 'Actual', 'Fitted')], id='time')
  
  p<-ggplot(graphset.melt,  aes(x=time,  y=value)) + geom_ribbon(data=graphset, aes(x=time, y=Fitted, ymin=Fitted-dev,  ymax=Fitted + dev),  alpha=.2,  fill=error.ribbon) + geom_line(aes(colour=variable), size=line.size) + geom_vline(x=max(actual_values$time),  lty=2) + xlab('Time') + ylab('Value') + opts(legend.position='bottom') + scale_colour_hue('')
  return(p)
  
}


HWplot(ts2, n.ahead=365, CI=.95, error.ribbon='green',line.size=1)



