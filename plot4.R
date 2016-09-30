data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, 
                   colClasses = c(NA, NA,"numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), 
                   na.strings = c("?"))
data <- transform(data, DateTime1 = paste(Date, Time))
data <- transform(data, DateTime = as.POSIXlt(strptime(DateTime1, format = "%d/%m/%Y %H:%M:%S", tz="")))
data <- subset(data, select = -c(DateTime1))
data <- subset(data, data$DateTime >= strptime("2007-02-01 00:00:00", format = "%Y-%m-%d %H:%M:%S") 
               & data$DateTime < strptime("2007-02-03 00:00:00", format = "%Y-%m-%d %H:%M:%S"))

#plot 4
png(filename = "plot4.png")
par(mfrow = c(2,2))
with(data, plot(DateTime, Global_active_power, type = "l", ylab = "Global Active Power", xlab = ""))
with(data, plot(DateTime, Voltage, type = "l", ylab = "Voltage", xlab = "datetime"))
with(data, plot(DateTime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "", col = "black"))
with(data, lines(DateTime, Sub_metering_2, type = "l", col = "red"))
with(data, lines(DateTime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), lwd = 1, col = c("black","red","blue"))
with(data, plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime"))
dev.off()