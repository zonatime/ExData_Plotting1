# eda_assignment_1_plot1.R
# Plot graph #1
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
png(filename = "plot1.png",
    width = 480, height = 480)

# plot #1 - histogram for Global Active Power
hist(epc_data$Global_active_power, 
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power",
     col = "red",
     #ylim = c(0,1200)
     )

# turn off png graphics device
dev.off()
