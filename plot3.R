## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset for only Baltimore data
balNEI <- subset(NEI, NEI$fips == "24510")

#Derived sum of emissions for each type in each year
typeNEI <- balNEI %>% group_by(type,year) %>% summarise(Emissions = sum(Emissions))

#Set plot destination
png("plot3.png")

#Plotting emissions for each type; Adding trend lines; Adding title
qplot(year, Emissions, data = typeNEI, facets = type~., geom = c("point", "smooth"), main = "Baltimore Emissions by type 1999-2008")
dev.off()