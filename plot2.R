#Basics
NEI <- readRDS("summarySCC_PM25.rds")
#fips: U.S. county (5 digits)
#SCC: The name of the source as indicated by a digit string
#Pollutant: A string indicating the pollutant
#Emissions: Amount of PM2.5 emitted, in tons
#type: The type of source (point, non-point, on-road, or non-road)
#year: The year of emissions recorded

SCC <- readRDS("Source_Classification_Code.rds")

#Plot 2 - Have total emissions from PM2.5 decreased in Baltimore from 1999 to 2008?
#Baltimore -> fips=='24510'
Balt.data<-subset(NEI,fips=='24510')
Emissions<-tapply(Balt.data$Emissions,Balt.data$year,sum)

##Colors for the points (how big is the pollution difference?)
library(grDevices)
rng<-range(Emissions)
col.info<-(Emissions-rng[1])/(rng[2]-rng[1])
colors<-rgb(1-col.info,1-col.info,1-col.info)

##Plot itself
png(filename='plot2.png')
par(bg = 'azure3')
plot(as.numeric(names(Emissions)),Emissions,xlab='Year', ylab='Total PM2.5 emission',type='o',cex=2,col=colors,pch=20,main='Total PM2.5 emission by year for Baltimore City, MA')
dev.off()
