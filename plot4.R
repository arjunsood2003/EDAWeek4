## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Retrieve SCC codes for coal combustion data
coalSCC<- subset(SCC$SCC, SCC$EI.Sector %in% grep("Coal", SCC$EI.Sector, value = TRUE))

#Subset for only coal combustion data
coalNEI<- subset(NEI, NEI$SCC %in% coalSCC)

#Derived sum of emissions for each year
yrNEI <- melt(with(coalNEI,tapply(Emissions,year,sum)))

#Naming columns of table correctly
names(yrNEI) <- c("Year", "Coal_Emissions")

#Set plot destination
png("plot4.png")

#Tweaking x-axis so all years are clearly annotated
par(lab = c(7,6,7))

#Plotting emissions for each year with wide histogram-like bars
with(yrNEI,plot(Year, Coal_Emissions, type = "h", lwd = 5))
title(main = "Coal-related pm2.5 Emissions USA 1999-2008")
dev.off()