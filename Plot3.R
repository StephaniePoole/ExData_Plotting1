# Reading, and naming power consumption data
power <- read.table("household_power_consumption.txt",skip=1,sep=";")
names(power) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

# subsetting power consumption data
subset_power <- subset(power,power$Date=="1/2/2007" | power$Date =="2/2/2007")

# The as.POSIX* functions convert an object to one of the two classes used 
# to represent date/times (calendar dates plus time to the nearest second).
subset_power$Date <- as.Date(subset_power$Date, format="%d/%m/%Y")
subset_power$Time <- strptime(subset_power$Time, format="%H:%M:%S")
subset_power[1:1440,"Time"] <- format(subset_power[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subset_power[1441:2880,"Time"] <- format(subset_power[1441:2880,"Time"],"2007-02-02 %H:%M:%S")


# Basic plot functions
plot(subset_power$Time,subset_power$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
with(subset_power,lines(Time,as.numeric(as.character(Sub_metering_1))))
with(subset_power,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
with(subset_power,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Adding a plot title to the graph
title(main="Energy sub-metering")

# Saving the plot to png format
dev.copy(png, filename="Plot3.png")
dev.off()

