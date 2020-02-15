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


## 4th plot
png("plot4.png", width=480, height=480)
## creating 4 quadrant
par(mfrow=c(2,2))
## Quadrant 1 
plot(datascopeDate$datetime, datascopeDate$Global_active_power, xlab = "", ylab = "Global Active Power", type = "l")
## Quadrant 2
plot(datascopeDate$datetime, datascopeDate$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
## Quadrant 3
plot(datascopeDate$datetime, 
     datascopeDate$Sub_metering_1,
     xlab = "", 
     ylab = "Energy sub metering",
     col = "black", 
     type = "l")
lines(datascopeDate$datetime, datascopeDate$Sub_metering_2, col = "red")
lines(datascopeDate$datetime, datascopeDate$Sub_metering_3, col = "blue")
legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lwd = 1)
## Quadrant 4
plot(datascopeDate$datetime, datascopeDate$Global_reactive_power,
     xlab = "datetime", ylab = "Global_reactive_power",
     col = "black",type = "l")
dev.off()
