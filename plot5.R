## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Retrieve SCC codes for mobile (vehicular) data
vehicleSCC<- subset(SCC$SCC, SCC$SCC.Level.One %in% grep("Mobile", SCC$SCC.Level.One, value = TRUE))

#Subset for only vehicular Baltimore data
balvehicleNEI<- subset(NEI, NEI$fips == "24510" & NEI$SCC %in% vehicleSCC)

#Derived sum of emissions for each year
yrNEI <- melt(with(balvehicleNEI,tapply(Emissions,year,sum)))

#Naming columns of table correctly
names(yrNEI) <- c("year", "Emissions")

#Set plot destination
png("plot5.png")

#Tweaking x-axis so all years are clearly annotated
par(lab = c(7,6,7), cex.axis = 0.8)

#Plotting emissions for each year with wide histogram-like bars
with(yrNEI,plot(year, Emissions, type = "h", lwd = 5))
title(main = "Total Baltimore motor vehicle Emissions 1999-2008")
dev.off()