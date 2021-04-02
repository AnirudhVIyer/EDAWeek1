library("data.table")

setwd("/Users/anirudhiyer/Desktop/RStudio")
#Reads data from file
Ptable <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")
# Prevents Scientific Notation
Ptable[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
# Making dateTime variable
Ptable[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
#2007-02-01 to 2007-02-02
Ptable <- Ptable[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]
png("plot4.png", width=480, height=480)
## making a grid
par(mfrow=c(2,2))
# Plot 1
plot(Ptable[, dateTime], Ptable[, Global_active_power], type="l", xlab="", ylab="Global Active Power")
# Plot 2
plot(Ptable[, dateTime],Ptable[, Voltage], type="l", xlab="datetime", ylab="Voltage")
# Plot 3
plot(Ptable[, dateTime], Ptable[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(Ptable[, dateTime], Ptable[, Sub_metering_2], col="red")
lines(Ptable[, dateTime], Ptable[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "), lty=c(1,1), bty="n", cex=.5) 

# Plot 4
plot(Ptable[, dateTime], Ptable[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()

