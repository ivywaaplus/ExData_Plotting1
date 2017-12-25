##Extract the data for 1/2/2007 and 2/2/2007
power<-"./household_power_consumption.txt"
header<-read.table(power, nrows=1, sep=";", stringsAsFactors=FALSE)
firstline<-min(grep("^1/2/2007",readLines(power)))
lastline<-max(grep("^2/2/2007",readLines(power)))           
dt<-read.table(power, skip=(firstline-1), nrows=(lastline-firstline+1), sep=";", header=FALSE, stringsAsFactors=FALSE)
colnames(dt)<-header[1,]

##convert string to date and time format and combine them to the data frame
dt$Date<-as.Date(dt$Date, "%d/%m/%Y")
dt<-cbind(dt, "DateTime"=as.POSIXct(paste(dt$Date, dt$Time)))

##use plot and lines functions
png(file="plot4.png",width=480, height=480)
par(mfcol=c(2,2))
plot(dt$DateTime, dt$Global_active_power, type="l", xlab="", ylab="Global Active power")
with(dt, {
  plot(DateTime, Sub_metering_1, type="l", xlab="", ylab="Energy Sub Metering")
  lines(DateTime, Sub_metering_2, col="red")
  lines(DateTime, Sub_metering_3, col="blue")
  legend("topright", lty=1, lwd=2,  col=c("black","red","blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  })
with(dt, plot(DateTime, Voltage, type="l", xlab="datetime"))
with(dt, plot(DateTime, Global_reactive_power, type="l", xlab="datetime"))
dev.off()  