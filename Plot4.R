## Getting full dataset
power_dataset <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
power_dataset$Date <- as.Date(power_dataset$Date, format="%d/%m/%Y")

## Subsetting the data
subset_data <- subset(power_dataset, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(power_dataset)

## Converting dates
datetime <- paste(as.Date(subset_data$Date), subset_data$Time)
# The as.POSIX* functions convert an object to one of the two classes used 
# to represent date/times (calendar dates plus time to the nearest second). 
subset_data$Datetime <- as.POSIXct(datetime)

# plotting graph
# oma = outer margin spacing definition
# the par( ) function, you can include the option mfrow=c(nrows, ncols) to 
# create a matrix of nrows x ncols plots that are filled in by row. mfcol=c(nrows, ncols) 
# fills in the matrix by columns.
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(subset_data, {
  plot(Global_active_power~Datetime, type="l",ylab="Global Active Power", xlab="datetime")
  plot(Voltage~Datetime, type="l", ylab="Voltage", xlab="datetime")
  plot(Sub_metering_1~Datetime,col='Blue', type="l", ylab="Energy sub metering", xlab="datetime")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Black')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l",ylab="Global Rective Power",xlab="datetime")
})


## Saving to file
dev.copy(png, file="Plot4.png", height=480, width=480)
dev.off()