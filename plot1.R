#----------------Read in the dataset - assumption that the file is in the same folder as the R code

#----------------NB: 1. Only the required rows are read in by specifying rows to skip and number to read (i.e. our date range).
#----------------    2. This also requires the column headings to be explicity read in and set as well.
#----------------    3. Has the advantage of skipping missing values which are outside of our date range.

names <- colnames(read.table("./household_power_consumption.txt", sep=";", nrow = 1, header = TRUE))

consumption <- read.table("./household_power_consumption.txt", sep=";", skip = 66637, nrow = 2880, col.names = names)

#----------------Good practice to clear the plot frame first

plot.new()

#----------------Create the histogram with all the required options to format according to the assignment specification
#----------------Set various element sizes to .8 of default size to meet requirements

title <- "Global Active Power"
x_lab <- "Global Active Power (kilowatts)"
adj = 0.8

hist(consumption$Global_active_power, main=title, col="red", xlab=x_lab, cex.main=adj, cex.lab=adj, cex.axis=adj, ylim=c(0, 1200))

#----------------Save the plot to a PNG file with the required dimensions
dev.copy(png, file = "./plot1.png", width = 480, height = 480, units = "px")
dev.off()

