library(ggplot2)
setwd("/Users/michel/dev/r-data-science/04ExploratoryDataAnalysis/ExData_Plotting2")
mydata <- readRDS("data/summarySCC_PM25.rds")
# subset Baltimore City
mydata <- subset(mydata, fips %in% c("24510", "06037"))

SCC <- readRDS("data/Source_Classification_Code.rds")
vehicle_sources <- SCC[grep("Mobile Sources", SCC$SCC.Level.One, perl = TRUE), 1]
vehicle_data <- subset(mydata, SCC %in% vehicle_sources)

emission <- aggregate(Emissions ~ year + fips, data=vehicle_data, FUN=sum)
emission[emission$fips == "24510", ]$fips = "Baltimore City"
emission[emission$fips == "06037", ]$fips = "Los Angeles County"
emission = transform(emission, year=factor(year), fips=factor(fips))

png(file="plot6.png")
g <- ggplot(emission,aes(year, Emissions, fill=fips))+geom_bar(position="dodge",stat="identity")+
    labs(title="Total emissions by motor vehices (Baltimore City)", x="Years", y="Emissions PM2.5 (tons)", fill="Region")
print(g)
dev.off()