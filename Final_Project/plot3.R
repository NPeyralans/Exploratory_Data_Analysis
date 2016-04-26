## I would have preferred to do a barplot of this data so that the reader
## wouldn't think that we actually have the data from dates in between
## the years that we have, but I really haven't figured out how to work in ggplot2 yet

## Loading the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)
library(plyr)

## Sub-set the data
baltimore <- subset(NEI, fips=="24510")

## Get the right data sorted by type and total emissions
baltimore_totals_by_type <- ddply(baltimore, .(year,type), function(x) sum(x$Emissions))

## Name the cols
names(baltimore_totals_by_type)[3] <- "Total_Emissions"

## Open the graphing device
png(filename="plot3.png", height=480, width=480)

## Make the plot
qplot(year, Total_Emissions, data = baltimore_totals_by_type, color = type, geom = "line") +
  ggtitle(expression("Baltimore City Emissions by Source Type and Year")) + xlab("Year") +
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))

dev.off()