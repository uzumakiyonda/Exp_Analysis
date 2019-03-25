#Basics
NEI <- readRDS("summarySCC_PM25.rds")
#fips: U.S. county (5 digits)
#SCC: The name of the source as indicated by a digit string
#Pollutant: A string indicating the pollutant
#Emissions: Amount of PM2.5 emitted, in tons
#type: The type of source (point, non-point, on-road, or non-road)
#year: The year of emissions recorded

SCC <- readRDS("Source_Classification_Code.rds")

ind<-SCC[COAL$Short.Name,1]
library(dplyr)
NEI<-as_tibble(NEI)
BIGNEI<-full_join(NEI,SCC,by='SCC')
COAL<-grep(BIGNEI$Short.Name,pattern='[Cc]oal')
BNEI<-BIGNEI[COAL,]
Emissions<-tapply(BNEI$Emissions,BNEI$year,sum)

##Colors for the points (how big is the pollution difference?)
library(grDevices)
rng<-range(Emissions)
col.info<-(Emissions-rng[1])/(rng[2]-rng[1])
colors<-rgb(1-col.info,1-col.info,1-col.info)

##Plot itself
png(filename='plot4.png')
par(bg = 'azure3')
plot(as.numeric(names(Emissions)),Emissions,xlab='Year', ylab='Coal PM2.5 emission',type='o',cex=2,col=colors,pch=20,main='Coal PM2.5 emission by year for the U.S.A.')
dev.off()
