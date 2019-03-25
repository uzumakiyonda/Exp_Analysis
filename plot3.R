#Basics
NEI <- readRDS("summarySCC_PM25.rds")
#fips: U.S. county (5 digits)
#SCC: The name of the source as indicated by a digit string
#Pollutant: A string indicating the pollutant
#Emissions: Amount of PM2.5 emitted, in tons
#type: The type of source (point, non-point, on-road, or non-road)
#year: The year of emissions recorded

SCC <- readRDS("Source_Classification_Code.rds")

Balt.data<-subset(NEI,fips=='24510')

#Plot 3 - Of the four sources (point, nonpoint, onroad, nonroad),
#which of them has seen decreases in emissions from 1999–2008 for Baltimore?
#Which have seen increases in emissions from 1999–2008?
#Use the ggplot2 plotting system to make a plot answer this question.
library(dplyr)
Balt.data<-as_tibble(subset(NEI,fips=='24510'))

##Applying sum by type and year
typeyear<-Balt.data%>%
  group_by(type,year)%>%
  summarise(sum(Emissions))

##Turning type to factor
typeyear$type<-as.factor(typeyear$type)
##Plotting
library(ggplot2)
png(filename='plot3.png')
g<-ggplot(typeyear,aes(year,`sum(Emissions)`,color=type))
g+geom_point(cex=2)+geom_line()+labs(x='Year',y='Total PM2.5 emission',title='Total emissions by source',subtitle='Baltimore City, MA')
dev.off()
