## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset for only Baltimore data
balNEI<- subset(NEI, NEI$fips == "24510")

#Derived sum of emissions for each year
yrNEI <- melt(with(balNEI,tapply(Emissions,year,sum)))

#Naming columns of table correctly
names(yrNEI) <- c("Year", "Emissions")

#Set plot destination
png("plot2.png")

#Tweaking x-axis so all years are clearly annotated
par(lab = c(7,6,7), cex.axis = 0.7)

#Plotting emissions for each year with wide histogram-like bars
with(yrNEI,plot(Year, Emissions, type = "h", lwd = 5))
title(main = "Total pm2.5 Emissions Baltimore 1999-2008")
dev.off()