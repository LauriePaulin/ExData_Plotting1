#----------------Read in the dataset - assumption that the file is in the same folder as the R code

#----------------NB: 1. Only the required rows are read in by specifying rows to skip and number to read (i.e. our date range).
#----------------    2. This also requires the column headings to be explicity read in and set as well.
#----------------    3. Has the advantage of skipping missing values which are outside of our date range.

names <- colnames(read.table("./household_power_consumption.txt", sep=";", nrow = 1, header = TRUE))

consumption <- read.table("./household_power_consumption.txt", sep=";", skip = 66637, nrow = 2880, col.names = names)

#----------------Get the date field in the right format, then add the time to it and make it a datetime
consumption$DateConvert <- as.Date(consumption$Date, "%d/%m/%Y")
consumption$DateTim <- as.POSIXct(paste(as.Date(consumption$DateConvert), consumption$Time))

#----------------Good practice to clear the plot frame first

plot.new()

#----------------Create a 2 by 2 plot area and reduce margins to fit it all in nicely
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

#----------------First plot
plot(consumption$Global_active_power~consumption$DateTim, type="l", cex.lab=0.8, cex.axis=0.8, main="", xlab="", ylab="Global Active Power")

#----------------Second plot
plot(consumption$Voltage~consumption$DateTim, type="l", main="", cex.lab=0.8, cex.axis=0.8, xlab="datetime", ylab="Voltage")

#----------------Third plot
#----------------Create the plot for the first measure. Use type parameter of 'l' for line graph

with(consumption, plot(DateTim, Sub_metering_1, main = "", cex.lab=0.8, cex.axis=0.8, type="l", xlab="", ylab="Energy sub metering"))

#----------------Add the other measure using the lines function as this will just add to the existing plot created above

with(consumption, lines(DateTim, Sub_metering_2, col="red"))
with(consumption, lines(DateTim, Sub_metering_3, col="blue"))

#----------------Add the required line legend, reduce its size by .5 to match the requirement

leg <- c("Sub_metering_1", "Sub_metering_2","Sub_metering_3    ")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend=leg, cex=.5, bty="n", xjust=0)

#----------------Fourth plot
plot(consumption$Global_reactive_power~consumption$DateTim, type="l", main="", cex.lab=0.8, cex.axis=0.7, xlab="datetime", ylab="Global_reactive_power", ylim=c(0, 0.5))

#----------------Save the plot to a PNG file with the required dimensions
dev.copy(png, file = "./plot4.png", width = 480, height = 480, units = "px")
dev.off()
