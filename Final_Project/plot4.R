## Loading the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Get the type to merge with NEI data
SCC_type <- subset(SCC, select = c("SCC", "Short.Name"))

## Merge the data
NEI_SCC <- merge(NEI, SCC_type, by.x="SCC", by.y="SCC", all=TRUE)

## Get coal related emissions
NEI_coal <- subset(NEI_SCC, grepl('Coal',NEI_SCC$Short.Name, fixed=TRUE), c("Emissions", "year","type", "Short.Name"))

## Get the desired info by year
coal_totals_by_year <- aggregate(Emissions ~ year, NEI_coal, sum)

## Convert to kilotons
coal_totals_by_year$Emissions <- sapply(coal_totals_by_year$Emissions, function(x) x/1000)

## Open the graphing device
png(filename="plot4.png", height=480, width=480)

## Make the plot
barplot(coal_totals_by_year$Emissions, 
        names.arg = coal_totals_by_year$year, 
        col=c("blue", "red", "green", "orange"), 
        main="Total Emissions from Coal in the USA",
        ylab="Kilotons of Emissions from Coal", ylim=c(0,700))

dev.off()