## At roughly 2,000,000,000 rows x 9 columns = 18,000,000,000 cells. 
## At 8 bytes/cell memory need, memory required would be 144GB.
## I have 8MB RAM on my laptop, more than enough memory to handle this data.
## The following code reads the data into a data frame from file and converts time and date variables to the proper datatypes
pwrdata <- read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
strptime(pwrdata$Time, "HH:MM:SS")
as.Date(pwrdata$Date)
## Subsets the data based on the date range given
pwrdatadates <- data[pwrdata$Date %in% c("1/2/2007","2/2/2007") ,]
## Converts the subsetted data to numeric
globalpower <- as.numeric(pwrdatadates$Global_active_power)
## Creates a .png file, defines the bar graph, creates the histogram and shuts down the graph after plotting is complete
png("plot1.png", width=480, height=480)
hist(globalpower, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()