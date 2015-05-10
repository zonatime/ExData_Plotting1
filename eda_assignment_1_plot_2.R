# Plot graph #2
#
# set up data frame to receive subset of full data file
epc_data = data.frame(Date = character(), 
                      Time = character(), 
                      Global_active_power = numeric(), 
                      Global_reactive_power = numeric(),
                      Voltage = numeric(),
                      Global_intensity = numeric(),
                      Sub_metering_1 = numeric(),
                      Sub_metering_2 = numeric(),
                      Sub_metering_3 = numeric(),
                      stringsAsFactors = FALSE)

# open connection to raw data file (very large)
conn <- file("household_power_consumption.txt", "r")

# set counter for while loop
# read 1 line at at time to test
# if (2|3)/02/2007 write line to data frame 
i=0
while(length(line <- readLines(conn, 1)) > 0) {
        ind <- grep("^(1|2)\\/2\\/2007", line)
        if (length(ind)) {
                vector = unlist(strsplit(line, ";"))
                i=i+1
                for (j in 1:2) epc_data[i,j] = as.character(vector[j])
                for (j in 3:9) epc_data[i,j] = as.numeric(vector[j])
        }
}

# close connection
close(conn)

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