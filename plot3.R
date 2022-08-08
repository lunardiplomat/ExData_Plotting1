file<- "./household_power_consumption.txt"
url<- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipDest<- "./dataset.zip"

#download file with checks
if (!file.exists(file))
{
  download.file(url, destfile = zipDest)
  unzip(zipDest)
  file.remove(zipDest)
}

#read the file we just downloaded into R
data<- read.table(file, header = TRUE, sep = ";",
                  colClasses = c(rep("character",2),
                                 rep("numeric", 7)),
                  na.strings = "?")

#subset the dates we need for our chart
dates<- data[data$Date=="1/2/2007" | data$Date=="2/2/2007",]

#add timestamp column so our chart can have a proper x axis
dates$timestamp <- strptime(paste(dates$Date, dates$Time), format = "%d/%m/%Y %H:%M:%S")

#create our png file so we can write to it
png(filename = "plot2.png", height = 480, width = 480)

#create a chart with no plots
plot(dates$timestamp, dates$Sub_metering_1, xlab="", ylab="Energy Sub Metering", type="n")
#add each submetering plot to the empty chart
lines(dates$timestamp, dates$Sub_metering_1, col="black")
lines(dates$timestamp, dates$Sub_metering_2, col="blue")
lines(dates$timestamp, dates$Sub_metering_3, col="red")
#add a legend
legend(x="right", legend=c("Sub meter 1", "Sub meter 2", "Sub meter 3"),
       col=c("black", "blue", "red"), lwd=1)