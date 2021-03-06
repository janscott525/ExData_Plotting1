## At roughly 2,000,000,000 rows x 9 columns = 18,000,000,000 cells. 
## At 8 bytes/cell memory need, memory required would be 144GB.
## I have 8MB RAM on my laptop, more than enough memory to handle this data.
## The following code reads the data into a data frame from file and converts time and date variables to the proper datatypes
pwrdata <- read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
strptime(pwrdata$Time, "HH:MM:SS")
as.Date(pwrdata$Date)
## Subsets the data based on the date range given
pwrdatadates <- data[pwrdata$Date %in% c("1/2/2007","2/2/2007") ,]
## Converts the subsetted data to appropriate data types
dttm <- strptime(paste(pwrdatadates$Date, pwrdatadates$Time, sep=" "), "%d/%m/%Y %H:%M:%S")  
glblpwr <- as.numeric(pwrdatadates$Global_active_power)
glblrctvpwr <-as.numeric(pwrdatadates$Global_reactive_power)
vltg <- as.numeric(pwrdatadates$Voltage)
submtrg1 <- as.numeric(pwrdatadates$Sub_metering_1) 
submtrg2 <- as.numeric(pwrdatadates$Sub_metering_2) 
submtrg3 <- as.numeric(pwrdatadates$Sub_metering_3) 
## Creates a .png file, defines and creates the graphs and shuts down the graphs after plotting is complete
png("plot4.png", width=480, height=480) 
par(mfrow = c(2, 2))
## Creates graph 1
plot(dttm, glblpwr, type="l", xlab="", ylab="Global Active Power", cex=0.2)
## Creates graph 2
plot(dttm, vltg, type="l", xlab="datetime", ylab="Voltage")
## Creates graph 3
plot(dttm, submtrg1, type="l", ylab="Energy Submetering", xlab="") 
lines(dttm, submtrg2, type="l", col="red") 
lines(dttm, submtrg3, type="l", col="blue") 
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")
## Creates graph 4
plot(dttm, glblrctvpwr, type="l", xlab="datetime", ylab="Global_reactive_power") 
dev.off()