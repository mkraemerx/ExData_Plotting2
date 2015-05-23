library(ggplot2)
setwd("/Users/michel/dev/r-data-science/04ExploratoryDataAnalysis/ExData_Plotting2")
mydata <- readRDS("data/summarySCC_PM25.rds")

mydata <- subset(mydata, fips=="24510")

#factorize
mydata = transform(mydata, year=factor(year), type=factor(type))
# sum up emissions and scale usefully
emission <- aggregate(Emissions ~ year + type, data=mydata, FUN=sum)
#names(emission) <- c("Year", "Source type", "Emissions PM2.5 (tons)")
#emission = transform(emission, x=x/1000)

png(file="plot3.png")
g <- ggplot(emission,aes(year, Emissions,fill=type))+geom_bar(position="dodge",stat="identity")+
    labs(title="Emissions by source type in Baltimore City", x="Years", y="Emissions PM2.5 (tons)", fill="Type of source")
print(g)
dev.off()