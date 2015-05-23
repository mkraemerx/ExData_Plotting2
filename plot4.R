library(ggplot2)
setwd("/Users/michel/dev/r-data-science/04ExploratoryDataAnalysis/ExData_Plotting2")
mydata <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")
coal_sources <- SCC[grep("Coal", SCC$EI.Sector, perl = TRUE), 1]
coal_data <- subset(mydata, SCC %in% coal_sources)

emission <- aggregate(Emissions ~ year, data=coal_data, FUN=sum)
emission = transform(emission, year=factor(year), Emissions=Emissions/1000)
png(file="plot4.png")
g <- ggplot(emission,aes(year, Emissions))+geom_bar(position="dodge",stat="identity")+
    labs(title="Total US Emissions by coal combustion", x="Years", y="Emissions PM2.5 (1000 tons)")
print(g)
dev.off()