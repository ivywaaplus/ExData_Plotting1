##Extract the data for 1/2/2007 and 2/2/2007
power<-"./household_power_consumption.txt"
header<-read.table(power, nrows=1, sep=";", stringsAsFactors=FALSE)
firstline<-min(grep("^1/2/2007",readLines(power)))
lastline<-max(grep("^2/2/2007",readLines(power)))           
dt<-read.table(power, skip=(firstline-1), nrows=(lastline-firstline+1), sep=";", header=FALSE, stringsAsFactors=FALSE)
colnames(dt)<-header[1,]

##use hist() function for this plot
png(file="plot1.png",width=480, height=480)
hist(dt$Global_active_power,col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()

