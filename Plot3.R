# QUESTION 3: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
# which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City?
# Which have seen increases in emissions from 1999-2008?
# Use the ggplot2 plotting system to make a plot answer this question.

# 1. Read and prepare data
NEI <- readRDS("summarySCC_PM25.rds")
library(dplyr)
NEIdp <- tbl_df(NEI)
# Baltimore emissions per year and type
BaltimoraEmissionsTypeYears = summarize(group_by(filter(NEIdp, fips=="24510"),type,year),sum(Emissions))
# renamed columns
colnames(BaltimoraEmissionsTypeYears) <- c("Type","Year", "Emissions")
# year converted to string
BaltimoraEmissionsTypeYears$Year <- as.character(BaltimoraEmissionsTypeYears$Year)

# 2. Plot
library(ggplot2)
png('plot3.png')
qplot(Year,data=BaltimoraEmissionsTypeYears, geom="bar", weight=Emissions, facets=.~Type, fill=Year, main='Baltimore City: Emissions (PM 2.5) per year and type', xlab='', ylab = 'Emissions (PM 2.5)')
dev.off()




