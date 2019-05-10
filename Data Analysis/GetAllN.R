#Import annual data and extract nitrates and nitrites

library(readr)

#import from year X

get_nitrates_nitrites <- function(startyear,)

startyear <- 2000
endyear <- 2019
Syear <- toString(startyear)
Eyear <- toString(endyear)
for (year in Syear:Eyear){
  X <- read_csv(paste("Years/", year, ".csv", sep = ""))
  Nitrates <- subset(X, determinand.definition=="Nitrate (2M KCl extractable) : Dry Wt" | determinand.definition=="Nitrate as N" 
                     | determinand.definition=="Nitrate, Filtered as N")
  Nitrites <- subset(X, determinand.definition=="Nitrite : Dry Wt as N"
                     | determinand.definition=="Nitrite as N" | determinand.definition=="Nitrite, Filtered as N")
  assign(paste("Nitrates", year, sep = ""), Nitrates)
  assign(paste("Nitrites", year, sep = ""), Nitrites)
  
}

accuNitra <- rbind(accuNitra, Nitrates2019)
accuNitri <- rbind(accuNitri, Nitrites2019)


AN01M04 <- subset(accuNitra, sample.samplingPoint.notation=="AN-01M04")

NitratesTemp <- subset(accuNitra, sample.sampledMaterialType.label=="MINEWATER (FLOWING/PUMPED)")
write.csv(NitratesTemp, "NitratesMinewaterFlow.csv")

write.csv(Nitrites2010, "Nitrites2010.csv")
