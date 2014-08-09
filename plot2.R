# SET UP:
# One time file download. Make sure you first setwd to where you 
# want to download and unpack the zip file.
fileURL <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
wd <- getwd()
destFile <- paste0(wd,'/household_power_consumption.zip')

if (!file.exists(destFile)) {
  download.file(fileURL,destfile=destFile, method='curl')
  unzip(destFile)
  dateDownloaded <- date()
}

# read in the data
colNames = c("date", "time", "globalActivePower", "globalReactivePower", "voltage", "globalIntensity", "subMetering1", "subMetering2", "subMetering3")
colClasses = c("character","character",rep("numeric",times=7))
df <- read.csv2("household_power_consumption.txt", header=TRUE, na.strings="?",col.names=colNames,colClasses=colClasses,dec=".")

# we really only want Feb 1 and 2, 2007
hpc <- df[df$date=='1/2/2007' | df$date=='2/2/2007',]

# Plot to a png file
png("plot2.png")
weekDays <- strptime(paste(hpc$date, hpc$time), format='%d/%m/%Y %H:%M:%S')
plot(weekDays, hpc$globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
