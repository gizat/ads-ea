X2010 <- read_csv("Jupyter Notebooks/ADS/2010.csv")

# Graph data --------------------------------------------------------------

data <- X2010$determinand.label
levels <- unique(data)
data <- X2010$determinand.definition
levels2 <- unique(data)

#Heavy Metals===========================================================

mercury <- subset(X2010, determinand.definition=="Mercury" | determinand.definition=="Mercury : Dry Wt" 
               | determinand.definition=="Mercury : Total load" | determinand.definition=="Mercury : Wet Wt"
               | determinand.definition=="Mercury, Dissolved" | determinand.definition=="Mercury, Leachable") 

cadmium <- subset(X2010, determinand.definition=="Cadmium" | determinand.definition=="Cadmium : Dry Wt" 
              | determinand.definition=="Cadmium : HF Digest : Dry Wt" | determinand.definition=="Cadmium : Total load"
              | determinand.definition=="Cadmium : Wet Wt" | determinand.definition=="Cadmium, Dissolved"
              | determinand.definition=="Cadmium, Leachable" 
              | determinand.definition=="Cadmium : DGT extract {Diffuse Gradient Thin Film Device}") 
  
arsenic <- subset(X2010, determinand.definition=="Arsenic" | determinand.definition=="Arsenic : Dry Wt" 
               | determinand.definition=="Arsenic : HF Digest : Dry Wt" | determinand.definition=="Arsenic : Wet Wt"
               | determinand.definition=="Arsenic, Dissolved" | determinand.definition=="Arsenic, Leachable") 

chromium <- subset(X2010, determinand.definition=="Chromium" | determinand.definition=="Chromium : Dry Wt" 
              | determinand.definition=="Chromium : HF Digest : Dry Wt" | determinand.definition=="Chromium : Load"
              | determinand.definition=="Chromium : Wet Wt" | determinand.definition=="Chromium Hexavalent"
              | determinand.definition=="Chromium Hexavalent : Dry Wt :- {Chromate}" 
              | determinand.definition=="Chromium, Dissolved" | determinand.definition=="Chromium, Leachable") 

thallium <- subset(X2010, determinand.definition=="Thallium : Dry Wt" | determinand.definition=="Thallium : Total") 

lead <- subset(X2010, determinand.definition=="Lead" | determinand.definition=="Lead : DGT extract {Diffuse Gradient Thin Film Device}" 
              | determinand.definition=="Lead : Dry Wt" | determinand.definition=="Lead : HF Digest : Dry Wt"
              | determinand.definition=="Lead : Wet Wt" | determinand.definition=="Lead, Dissolved"
              | determinand.definition=="Lead, Leachable")

antimony <- subset(X2010, determinand.definition=="Antimony" | determinand.definition=="Antimony : Dry Wt" 
              | determinand.definition=="Antimony, Leachable" )

copper <- subset(X2010, determinand.definition=="Copper" | determinand.definition=="Copper (BS 3882) : Dry Wt" 
                 | determinand.definition=="Copper : DGT extract {Diffuse Gradient Thin Film Device}" 
                 | determinand.definition=="Copper : Dry Wt" | determinand.definition=="Copper : HF Digest : Dry Wt" 
                 | determinand.definition=="Copper : Load"
                 | determinand.definition=="Copper : Wet Wt" 
                 | determinand.definition=="Copper, Dissolved" | determinand.definition=="Copper, Leachable") 

selenium <- subset(X2010, determinand.definition=="Selenium" | determinand.definition=="Selenium : Dry Wt" 
               | determinand.definition=="Selenium : Wet Wt" | determinand.definition=="Selenium, Dissolved"
               | determinand.definition=="Selenium, Leachable" | determinand.definition=="Selenium, Leachable : Dry Wt")

HeavyMetals <- rbind(antimony, arsenic, cadmium, chromium, copper, lead, mercury, selenium, thallium)

write.csv(HeavyMetals, "Seperated/HeavyMetals.csv")



#Nitrates and Nitrites===========================================================

Nitrates <- subset(X2010, determinand.definition=="Nitrate (2M KCl extractable) : Dry Wt" | determinand.definition=="Nitrate as N" 
                   | determinand.definition=="Nitrate, Filtered as N")

Nitrites <- subset(X2010, determinand.definition=="Nitrite : Dry Wt as N"
                   | determinand.definition=="Nitrite as N" | determinand.definition=="Nitrite, Filtered as N")

write.csv(Nitrates, "Nitrates.csv")
write.csv(Nitrites, "Nitrites.csv")


#Fluride=========================================================================

Fluoride <- subset(X2010, determinand.definition=="Fluoride" | determinand.definition=="Fluoride : Dry Wt" 
                  | determinand.definition=="Fluoride, Leachable" | determinand.definition=="Fluoride, Leachable : Dry Wt")

write.csv(Fluoride, "Seperated/Fluoride.csv")


#Radionuclides=========================================================================

radionuclides <- subset(X2010, determinand.definition=="Uranium")

write.csv(radionuclides, "Seperated/Uranium.csv")

#================================================================================


merc2 <- subset(X2010, grepl(determinand.definition, 'Mercury'))

'''{r}

'''