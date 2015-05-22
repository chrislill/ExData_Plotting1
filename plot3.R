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

# Create Plot 3
png("plot3.png", bg="transparent")
plot(power.feb$Datetime, 
     power.feb$Sub_metering_1,
     type="l",
     xlab = "",
     ylab = "Energy sub metering")
lines(power.feb$Datetime, 
     power.feb$Sub_metering_2,
     col = "red")
lines(power.feb$Datetime, 
      power.feb$Sub_metering_3,
      col = "blue")
legend(x = "topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1,
       col = c("black", "red", "blue"))
dev.off()