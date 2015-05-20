library(dplyr)
library(lubridate)

# First check whether the file exists, and if not, create it
if (!file.exists("household_power_consumption.txt")) {
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url, "PowerConsumption.zip")
    unzip("PowerConsumption.zip")
}

# If the dataset for these plots doesn't exist, create it
if (!exists("power.feb")) {
    power.classes <- c("character", "character", rep("numeric",7))
    power.all <- read.csv("household_power_consumption.txt", 
                          sep = ";",
                          na.strings = "?",
                          colClasses = power.classes)
    power.feb <- power.all[power.all$Date %in% c("1/2/2007", "2/2/2007"),]
    rm(power.all)
    
    # Convert to a datetime object
    power.feb <- power.feb %>%
        mutate(Datetime = paste(Date, Time)) %>%
        mutate(Datetime = dmy_hms(Datetime))
}

# Create Plot 2
png("plot2.png", bg="transparent")
plot(power.feb$Datetime, 
     power.feb$Global_active_power,
     type="l"
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()