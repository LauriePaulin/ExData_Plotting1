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

#----------------Nothing too special about the plot required, mostly defaults apply. Use type parameter of 'l' for line graph

plot(consumption$Global_active_power~consumption$DateTim, type="l", main="", cex.lab=0.8, cex.axis=0.8, xlab="", ylab="Global Active Power (kilowatts)")

#----------------Save the plot to a PNG file with the required dimensions
dev.copy(png, file = "./plot2.png", width = 480, height = 480, units = "px")
dev.off()


