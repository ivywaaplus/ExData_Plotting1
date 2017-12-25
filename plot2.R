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

##use plot() function for this plot
plot(dt$DateTime, dt$Global_active_power, type="l", xlab="", ylab="Global Active power(kilowatts)")
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()