#Basics
NEI <- readRDS("summarySCC_PM25.rds")
#fips: U.S. county (5 digits)
#SCC: The name of the source as indicated by a digit string
#Pollutant: A string indicating the pollutant
#Emissions: Amount of PM2.5 emitted, in tons
#type: The type of source (point, non-point, on-road, or non-road)
#year: The year of emissions recorded

SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
BIGNEI<-full_join(NEI,SCC,by='SCC')

#Plot 5 - Mobile related combustions
MOTOR<-grep(BIGNEI$EI.Sector,pattern='[Mm]obile')
Balt.mobile<-BIGNEI[MOTOR,]%>%
  filter(fips=='24510')
Emissions<-tapply(Balt.mobile$Emissions,Balt.mobile$year,sum)

##Colors for the points (how big is the pollution difference?)
library(grDevices)
rng<-range(Emissions)
col.info<-(Emissions-rng[1])/(rng[2]-rng[1])
colors<-rgb(1-col.info,1-col.info,1-col.info)

##Plot itself
png(filename='plot5.png')
par(bg = 'azure3')
plot(as.numeric(names(Emissions)),Emissions,xlab='Year', ylab='PM2.5 emission from motor vehicle sources',type='o',cex=2,col=colors,pch=20,main='PM2.5 emission from motor vehicle sources by year for Baltimore City, MA')
dev.off()