# eda_assignment_1_plot2.R
# Plot graph #2
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
png(filename = "plot2.png",
    width = 480, height = 480)

# plot #2 -  line chart for Global Active Power

# get the range for the x and y axis for plot #2
xrange <- range(epc_data$DateTime) 
yrange <- range(epc_data$Global_active_power)

# set up  plot #2 
par (mar = c(3, 4, 1, 1))
plot(xrange, yrange, type="n", xlab ="",
     ylab="Global Active Power (kilowatts)") 

# plot the lines for #2
lines(epc_data$DateTime, epc_data$Global_active_power, lty=1)

# turn off png graphics device
dev.off()
