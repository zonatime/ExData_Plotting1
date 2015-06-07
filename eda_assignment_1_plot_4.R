# eda_assignment_1_plot4.R
# Plot graph #4
#
# source the data handling functions
source("get_EPC_data.R")

# check for data, download and unzip if not present
source_file = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dest_file = "exdata-data-household_power_consumption.zip"
data_file = "household_power_consumption.txt"
check_EPC_data(source_file, dest_file, data_file)

# subset for "1/2/2007" and "2/2/2007"
epc_data <- subset_EPC_data(data_file)

# combine Date & Time; convert to DateTime value
epc_data$DateTime <- paste(epc_data$Date, epc_data$Time)
epc_data$DateTime <- strptime(epc_data$DateTime, "%d/%m/%Y %H:%M:%S", tz = "UTC")

# set graphics device to png; configure
png(filename = "plot4.png",
    width = 480, height = 480)

# set up 2 x 2 grid for plotting
par(mfrow=c(2,2))

# plot #1 -  line chart for Global Active Power

# get the range for the x and y axis for plot #1
xrange <- range(epc_data$DateTime) 
yrange <- range(epc_data$Global_active_power)

# set up margins for all plots
par (mar = c(5, 4, 1, 1), mgp=c(3, 1, 0))

# set up  plot #1 
plot(xrange, yrange, type="n", xlab ="",
     ylab="Global Active Power") 

# plot the lines for #1
lines(epc_data$DateTime, epc_data$Global_active_power, lty=1) 

# plot #2 -  line chart for Voltage
# get the range for the x and y axis for plot #2
xrange <- range(epc_data$DateTime) 
yrange <- range(epc_data$Voltage)
#
# set up  plot #2 
plot(xrange, yrange, type="n", xlab ="datetime",
     ylab="Voltage") 

# plot the lines for #2
lines(epc_data$DateTime, epc_data$Voltage, lty=1) 

#
## plot #3
##
# get the range for the x and y axis for plot #3
xrange <- range(epc_data$DateTime) 
ymax <- max(c(max(epc_data$Sub_metering_1), 
              max(epc_data$Sub_metering_2),
              max(epc_data$Sub_metering_3)))
yrange <- c(0,ymax)

# set up  plot #3 
plot(xrange, yrange, type="n", xlab ="",
     ylab="Energy sub metering") 

# plot the lines for plot #3
lines(epc_data$DateTime, epc_data$Sub_metering_1, lty=1, col = "black") 
lines(epc_data$DateTime, epc_data$Sub_metering_2, lty=1, col = "red")
lines(epc_data$DateTime, epc_data$Sub_metering_3, lty=1, col = "blue")
legend("topright", col = c("black", "red", "blue"), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=c(1,1,1), bty="n")

#
# plot #4 -  line chart for Global_reactive_power

# get the range for the x and y axis for plot #2
xrange <- range(epc_data$DateTime) 
yrange <- range(epc_data$Global_reactive_power)
#
# set up  plot #4 
plot(xrange, yrange, type="n", xlab ="datetime",
     ylab="Global_reactive_power") 

# plot the lines for #4
lines(epc_data$DateTime, epc_data$Global_reactive_power, lty=1) 

# turn off png graphics device
dev.off()
