library("data.table")
setwd("/Users/anirudhiyer/Desktop/RStudio")
#Reads in data from file 
Ptable <- data.table::fread(input = "household_power_consumption.txt" , na.strings="?")
# Prevents Scientific Notation
Ptable[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
# Making dateTime variable
Ptable[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
# 2007-02-01 to 2007-02-02
Ptable <- Ptable[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot3.png", width=480, height=480)

# Plot 3
plot(Ptable[, dateTime], Ptable[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(Ptable[, dateTime], Ptable[, Sub_metering_2],col="red")
lines(Ptable[, dateTime], Ptable[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))

dev.off()

