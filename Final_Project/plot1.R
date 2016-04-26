## Loading the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Get data-frames for each year
data_1999 <- subset(NEI, year==1999)
data_2002 <- subset(NEI, year==2002)
data_2005 <- subset(NEI, year==2005)
data_2008 <- subset(NEI, year==2008)

## Get the total emissions
total_1999 <- sum(data_1999$Emissions)
total_2002 <- sum(data_2002$Emissions)
total_2005 <- sum(data_2005$Emissions)
total_2008 <- sum(data_2008$Emissions)

## Make a vector for the barplot
totals_by_year <- c(total_1999, total_2002, total_2005, total_2008)

## convert tons to kilotons
totals_by_year <- sapply(totals_by_year, function(x) x/1000)

## Make a vector to label each bars by year
years <- as.numeric(as.character(unique(NEI$year)))

## Open up the graphing device (png)
png(filename="plot1.png", height=480, width=480)

## Make the plot
barplot(totals_by_year, names.arg = years, 
        col=c("blue", "red", "green", "orange"), 
        main="Total Emission Levels By Year", 
        ylab="Kilotons of Emission from All Sources",
        ylim=c(0,8000))

## Close the png device
dev.off()