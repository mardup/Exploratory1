##GETTING DATA
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileName <- "household_power_consumption.zip"
dataFile <- "household_power_consumption.txt"

## Download and unzip the data
download.file(fileURL, fileName, method="curl")
unzip(fileName)

## This file is for loading the large dataset.
data <- read.table(dataFile, header = TRUE,sep = ";",colClasses = c("character", "character", rep("numeric",7)),na = "?")
datascope <- data[data[, "Date"] %in% c("1/2/2007","2/2/2007") ,]

#summary(datascopeDate)
datetime <- strptime(paste(datascope[, "Date"], datascope[, "Time"], sep=" "), "%d/%m/%Y %H:%M:%S")
datascopeDate <- cbind(datetime,datascope)
numericFields <- c("Global_active_power",
                   "Global_reactive_power",
                   "Voltage",
                   "Global_intensity",
                   "Sub_metering_1",
                   "Sub_metering_2",
                   "Sub_metering_3")
for (fieldName in numericFields) {
  datascopeDate[, fieldName] <- as.numeric(datascopeDate[, fieldName])
}

##1st Plot
png("plot1.png", width=480, height=480)
hist(datascopeDate$Global_active_power,
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)",
     breaks = 12, ylim = c(0, 1200))
dev.off()
