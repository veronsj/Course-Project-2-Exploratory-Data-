# QUESTION 4: Across the United States, how have emissions from coal combustion-related sources changed
# from 1999???2008?

# 1. Read and prepare data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# merge the tables
NEISCC <- merge(NEI, SCC, by="SCC")
library(dplyr)
NEISCCdp <- tbl_df(NEISCC)
# search for "coal" and create boolean column
NEISCCdp <- mutate(NEISCCdp, coal = grepl("coal", NEISCCdp$Short.Name, ignore.case=TRUE)) 
#renamed columns
EmissionsCoalYear <- summarize(group_by(filter(NEISCCdp, coal==TRUE),year),sum(Emissions))
colnames(EmissionsCoalYear) <- c("Year", "Emissions") 
# year converted to string
EmissionsCoalYear$Year <- as.character(EmissionsCoalYear$Year)
#new column with emissions in thousands (for the y axis)
EmissionsCoalYear$EmissionsInTousands = EmissionsCoalYear$Emissions/1000

# 2. Plot
library(ggplot2)
png('plot4.png')
g <- ggplot(EmissionsCoalYear, aes(Year, EmissionsInTousands))
g+geom_bar(stat='identity')+labs(title="Emissions from coal combustion-related sources", x="Years",y="Emissions (PM 2.5) in thousands")
dev.off()




