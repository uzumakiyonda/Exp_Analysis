#Basics
NEI <- readRDS("summarySCC_PM25.rds")
#fips: U.S. county (5 digits)
#SCC: The name of the source as indicated by a digit string
#Pollutant: A string indicating the pollutant
#Emissions: Amount of PM2.5 emitted, in tons
#type: The type of source (point, non-point, on-road, or non-road)
#year: The year of emissions recorded

SCC <- readRDS("Source_Classification_Code.rds")

BIGNEI<-full_join(NEI,SCC,by='SCC')

MOTOR<-grep(BIGNEI$EI.Sector,pattern='[Mm]obile')
Balt.mobile<-BIGNEI[MOTOR,]%>%
  filter(fips=='24510')
Emissions<-tapply(Balt.mobile$Emissions,Balt.mobile$year,sum)

#Plot 6
LA.mobile<-BIGNEI[MOTOR,]%>%
  filter(fips=='06037')
Emissions2<-tapply(LA.mobile$Emissions,LA.mobile$year,sum)

##Colors for the points (how big is the pollution difference?)
library(grDevices)
rng<-range(Emissions,Emissions2)
col.info<-(c(Emissions,Emissions2)-rng[1])/(rng[2]-rng[1])
colors<-rgb(1-col.info,1-col.info,1-col.info)

##Plot itself
png(filename='plot6.png')
par(bg = 'azure3')
plot(as.numeric(names(Emissions)),Emissions,xlab='Year', ylab='PM2.5 emission from motor vehicle sources',type='o',cex=2,col=colors[1:4],pch=20,main='PM2.5 emission from motor vehicle sources by year for different cities',ylim=rng)
lines(as.numeric(names(Emissions)),Emissions2,type='o',cex=2,col=colors[5:8],pch=20,lty=2)
legend('center',c('Los Angeles, CA','Baltimore City, MA'),lty=c(2,1),cex=2,bty='n')
dev.off()