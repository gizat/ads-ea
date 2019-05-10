library(readr)

install.packages('httr')
library(httr)
install.packages('plyr')
library(plyr)
install.packages('fitdistrplus')
library(fitdistrplus)
install.packages('logspline')
library(logspline)

options(scipen=999)  # turn off scientific notation like 1e+06
library(ggplot2)


#NitratesNitrites1 <- read_csv("Downloads/NitratesNitrites1.csv")
NitratesAll <- read_csv("Documents/AppliedDataScience/SepAll/NitratesAll.csv")


testString <- "NE-49700386"
testString <- "NE-49700246"
testString <- "AN-DEB030"
testString <- "NE-49500626"


testArea <- subset(NitratesAll, sample.samplingPoint.notation==testString)
testAreaEasting <- testArea$sample.samplingPoint.easting[1]
testAreaNorthing <- testArea$sample.samplingPoint.northing[1]


firstIndex <- 0
lastIndex <- (nrow(testArea)-5)
ta2 <- testArea[order(testArea$result),]
ta2 <- ta2[1:197,]
testArea <- ta2



NN1 <- sort(testArea$result)
#NN2 <- NN1[46:length(NN1)]
#NN1 <- NN2

#find average and range
print(paste("Range of readings at ", testString, "is ", min(NN1), "-", max(NN1)))
print(paste("Mean of readings at ", testString, "is ", mean(NN1)))


d1 = descdist(NN1, discrete = FALSE)

h = hist(NN1, breaks = 25)


#could be beta or gamma distribution
fit.weibull <- fitdist(NN1, "weibull") #close to gamma
fit.norm <- fitdist(NN1, "norm")
fit.beta <- fitdist(NN1, "beta")

plot(fit.norm)
plot(fit.weibull)



sp1 <- ggplot(testArea, aes(x=sample.sampleDateTime, y=result)) + geom_point( size=1)# + geom_smooth(method="lm")
sp1 + ggtitle("Time vs Nitrate Level", subtitle=paste("at ", testString, " (", testAreaEasting, ",", testAreaNorthing,")", sep = "")) + xlab("Date") + ylab("result (mg/L")

sp1 <- ggplot(testArea, aes(x=sample.sampleDateTime, y=result)) + geom_point(col="steelblue", size=1) + geom_smooth(method="loess", span = 0.07)
sp1 + ggtitle("Time vs Nitrate Level with LOESS", subtitle=paste("at ", testString, " (", testAreaEasting, ",", testAreaNorthing,")", sep = "")) + xlab("Date") + ylab("result (mg/L")
