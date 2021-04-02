library("data.table")
setwd("/Users/anirudhiyer/Desktop/RStudio")
#Reads in data from file 
Ptable <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")
# Prevents Scientific Notation
Ptable[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
# Making dateTime variable
Ptable[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
# Filter Dates for 2007-02-01 and 2007-02-02
Ptable <- Ptable[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot2.png", width=480, height=480)

## Plot 2
plot(x = Ptable[, dateTime]
     , y = Ptable[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()

