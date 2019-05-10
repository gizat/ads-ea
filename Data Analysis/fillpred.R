install.packages('devtools')
library(devtools)
install.packages('quadprog')
llibrary(imputeTS)
install.packages("fpp")
library(fpp)


statsNA(ta)



demand <- ts(ts1[,2], start = c(2000, 1), frequency = 365)
demand2<- ts(BJsales, start = c(2000, 1), frequency = 12)
demand2[4] <- NA

plot(na.seadec(demand, algorithm = "interpolation") - demand, ylim = c(-mean(demand), mean(demand)), ylab = "Difference", main = "Seas-Adj -> Linear")

ts2 <- ts[((365)*2):length(ts)]
ts2 <- ts(ts2, frequency = 365)

plot(ts2)

hw <- HoltWinters(ts2)
plot(hw)

forecast <- predict(hw, n.ahead = 365, prediction.interval = T, level = 0.95)
plot(hw, forecast, ylim=c(0, 35))
