## Loading the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Sub-set the data
baltimore <- subset(NEI, fips=="24510")

## Sort each year
baltimore_1999 <- subset(baltimore, year==1999)
baltimore_2002 <- subset(baltimore, year==2002)
baltimore_2005 <- subset(baltimore, year==2005)
baltimore_2008 <- subset(baltimore, year==2008)

## Sum the emissions
baltimore_total_1999 <- sum(baltimore_1999$Emissions)
baltimore_total_2002 <- sum(baltimore_2002$Emissions)
baltimore_total_2005 <- sum(baltimore_2005$Emissions)
baltimore_total_2008 <- sum(baltimore_2008$Emissions)

## Create a vector to plot
baltimore_totals <- c(baltimore_total_1999, baltimore_total_2002, 
                      baltimore_total_2005, baltimore_total_2008)

## Convert to kilotons
baltimore_totals <- sapply(baltimore_totals, function(x) x/1000)

## Get year vector for barnames
years <- as.numeric(as.character(unique(NEI$year)))

## Open plotting device
png(filename="plot2.png", width = 480, height=480)

## Plot
barplot(baltimore_totals, names.arg = years, 
        col=c("blue", "red", "green", "orange"), 
        main="Total Emissions in Baltimore City", 
        ylab="Kilotons of Emission from All Sources",
        ylim=c(0,3.5))

## Close the device
dev.off()


