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
data<- read.table(file, header = T, sep = ";", colClasses = rep("character",9))

#reclass relevant variables for the graph and subset
data$Date<- as.Date(data$Date, format = "%d/%m/%Y")

#subset dates we want
dates<- data[data$Date=="2007-02-01" | data$Date=="2007-02-02",]

#need the data to be numeric for the graph to work
dates$Global_active_power<- as.numeric(dates$Global_active_power)

#plot global_active_power variable
png(file="plot1.png", width=480, height=480, units="px")
hist(dates$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()
