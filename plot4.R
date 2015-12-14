## Read and transform the data
x <- read.table("household_power_consumption.txt",skip = 1, sep = ";", dec = ".", stringsAsFactors=FALSE)
x$V1 <- as.Date(x$V1, "%d/%m/%Y")
z <- x$V1>c("2007-01-31")
x1 <- x[z, ][, ]
z1 <- x1$V1<c("2007-02-03")
x1 <- x1[z1, ][, ]

x1$V3 <- as.numeric(x1$V3)
x1$V4 <- as.numeric(x1$V4)
x1$V5 <- as.numeric(x1$V5)
x1$V6 <- as.numeric(x1$V6)
x1$V7 <- as.numeric(x1$V7)
x1$V8 <- as.numeric(x1$V8)
x1$V9 <- as.numeric(x1$V9)
coln <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity","Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
colnames(x1) <- coln

dt <- paste(as.Date(x1$Date), x1$Time)
x1$dt <- as.POSIXct(dt)
coln <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity","Sub_metering_1", "Sub_metering_2", "Sub_metering_3", "datetime")
colnames(x1) <- coln


## Plot
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2))
plot(x1$datetime, x1$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
plot(x1$datetime, x1$Voltage, type="l", xlab="datetime", ylab="Voltage")
plot(x1$datetime, x1$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(x1$Sub_metering_3 ~ x1$datetime, col = "blue")
lines(x1$Sub_metering_2 ~ x1$datetime, col = "red")
legend("topright", col=c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5)
plot(x1$datetime, x1$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()