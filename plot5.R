library(ggplot2)
setwd("/Users/michel/dev/r-data-science/04ExploratoryDataAnalysis/ExData_Plotting2")
mydata <- readRDS("data/summarySCC_PM25.rds")
# subset Baltimore City
mydata <- subset(mydata, fips=="24510")

SCC <- readRDS("data/Source_Classification_Code.rds")
vehicle_sources <- SCC[grep("Mobile Sources", SCC$SCC.Level.One, perl = TRUE), 1]
vehicle_data <- subset(mydata, SCC %in% vehicle_sources)

emission <- aggregate(Emissions ~ year, data=vehicle_data, FUN=sum)
emission = transform(emission, year=factor(year))
png(file="plot5.png")
g <- ggplot(emission,aes(year, Emissions))+geom_bar(position="dodge",stat="identity")+
    labs(title="Total emissions by motor vehices (Baltimore City)", x="Years", y="Emissions PM2.5 (tons)")
print(g)
dev.off()