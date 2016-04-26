## Although the use of long variables may be cumbersome, I find it greatly
## eases the readability and keeping the data straight

## Loading the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Get the type to merge with NEI data
SCC_type <- subset(SCC, select = c("SCC", "Short.Name"))

## Merge the data
NEI_SCC <- merge(NEI, SCC_type, by.x="SCC", by.y="SCC", all=TRUE)

## Subset the required data
baltimore_on_road <- subset(NEI_SCC, fips == "24510" & type =="ON-ROAD", c("Emissions", "year","type"))
la_on_road <- subset(NEI_SCC, fips == "06037" & type == "ON-ROAD", c("Emissions", "year", "type"))

## House-keeping: factorize type
baltimore_on_road$type <- as.factor(baltimore_on_road$type)
la_on_road$type <- as.factor(la_on_road$type)

## Get sums by year
baltimore_on_road_by_year <- aggregate(Emissions ~ year, baltimore_on_road, sum)
la_on_road_by_year <- aggregate(Emissions ~ year, la_on_road, sum)

## Open the graphing device
png(filename="plot6.png", height=480, width=480)

## Set up my canvas
par(mfrow=c(1,2))

## Plot
barplot(la_on_road_by_year$Emissions, 
        names.arg = la_on_road_by_year$year, 
        col=c("red"), 
        main="Los Angeles",
        ylab="Tons of Emissions", ylim=c(0,5000))

barplot(baltimore_on_road_by_year$Emissions, 
        names.arg = baltimore_on_road_by_year$year, 
        col=c("blue"), 
        main="Baltimore City",
        ylab="Tons of Emissions", ylim=c(0,5000))

dev.off()