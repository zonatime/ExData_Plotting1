# eda_assignment_1_plot3.R
# Plot graph #3
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
png(filename = "plot3.png",
    width = 480, height = 480)

## plot #3
##
# get the range for the x and y axis for plot #3
xrange <- range(epc_data$DateTime) 
ymax <- max(c(max(epc_data$Sub_metering_1), 
              max(epc_data$Sub_metering_2),
              max(epc_data$Sub_metering_3)))
yrange <- c(0,ymax)

# set up  plot #3 
par (mar = c(3, 4, 1, 1))
plot(xrange, yrange, type="n", xlab ="",
     ylab="Energy sub metering") 

# plot the lines for plot #3
lines(epc_data$DateTime, epc_data$Sub_metering_1, lty=1, col = "black") 
lines(epc_data$DateTime, epc_data$Sub_metering_2, lty=1, col = "red")
lines(epc_data$DateTime, epc_data$Sub_metering_3, lty=1, col = "blue")
legend("topright", col = c("black", "red", "blue"), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=c(1,1,1))

# turn off png graphics device
dev.off()
