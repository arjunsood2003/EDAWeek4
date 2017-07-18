## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Retrieve SCC codes for mobile (vehicular) data
vehicleSCC<- subset(SCC$SCC, SCC$SCC.Level.One %in% grep("Mobile", SCC$SCC.Level.One, value = TRUE))

##Baltimore

#Subset for only vehicular Baltimore data
balvehicleNEI<- subset(NEI, NEI$fips == "24510" & NEI$SCC %in% vehicleSCC)

#Derived sum of emissions for each year
balyrNEI <- melt(with(balvehicleNEI,tapply(Emissions,year,sum)))

#Naming columns of table correctly
names(balyrNEI) <- c("year", "Emissions")

##Los Angeles County

#Subset for only vehicular LA County data
lacvehicleNEI<- subset(NEI, NEI$fips == "06037" & NEI$SCC %in% vehicleSCC)

#Derived sum of emissions for each year
lacyrNEI <- melt(with(lacvehicleNEI,tapply(Emissions,year,sum)))

#Naming columns of table correctly
names(lacyrNEI) <- c("year", "Emissions")

#Set plot destination
png("plot6.png")

#Tweaking x-axis so all years are clearly annotated
par(lab = c(7,6,7), cex.axis = 0.7, cex.main = 0.8)
par(mfcol = c(1,2))

#Plotting emissions for each year with wide histogram-like bars
with(balyrNEI,plot(year, log(Emissions), type = "h", lwd = 5))
title(main = "Baltimore vehicle Emissions")


with(lacyrNEI,plot(year, log(Emissions), type = "h", lwd = 5))
title(main = "Los Angeles vehicle Emissions")
dev.off()