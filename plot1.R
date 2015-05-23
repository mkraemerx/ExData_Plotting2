setwd("/Users/michel/dev/r-data-science/04ExploratoryDataAnalysis/ExData_Plotting2")
mydata <- readRDS("data/summarySCC_PM25.rds")

#factorize
mydata = transform(mydata, year=factor(year))
# sum up emissions and scale usefully
emission <- aggregate(mydata$Emissions, by=list(year=mydata$year), FUN=sum)
emission = transform(emission, x=x/1000)

#prepare reference lines
emission_max <- max(emission$x)
line_levels <- seq(1000, emission_max, 1000)

#plot
png(file="plot1.png")
#unfortunately I wasn't able to create an empty barplot or plot with type="n" :-(
barplot(emission$x, names.arg=(levels(emission$year)), xlab="Years", ylab="PM2.5 (1000 tons)")
abline(h=line_levels, col="grey")
barplot(emission$x, col="orange", add=TRUE)
dev.off()