data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, 
                   colClasses = c(NA, NA,"numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), 
                   na.strings = c("?"))
data <- transform(data, DateTime1 = paste(Date, Time))
data <- transform(data, DateTime = as.POSIXlt(strptime(DateTime1, format = "%d/%m/%Y %H:%M:%S", tz="")))
data <- subset(data, select = -c(DateTime1))
data <- subset(data, data$DateTime >= strptime("2007-02-01 00:00:00", format = "%Y-%m-%d %H:%M:%S") 
               & data$DateTime < strptime("2007-02-03 00:00:00", format = "%Y-%m-%d %H:%M:%S"))

#plot 2
png(filename = "plot2.png")
with(data, plot(DateTime, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))
dev.off()