#Download the file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "./powerData.zip")
unzip("./powerData.zip")

#Read in the data
pData<-read.table("./household_power_consumption.txt",header = TRUE,sep=";",stringsAsFactors = FALSE)
head(pData)
str(pData)

#Fix dates and times
newdates<-strptime(pData$Date,format="%d/%m/%Y")
pData$Date<-as.POSIXct(newdates)
newtimes<-strptime(pData$Time,format = "%T")
pData$TIME<-as.POSIXct(newtimes)

#Reduce the DF
pData<-subset(pData,Date == '2007-02-01' | Date == '2007-02-02')

#Make plot
#Make combined dat time column
pData$DATETIME<-as.POSIXct(paste(pData$Date, pData$Time), format="%Y-%m-%d %H:%M:%S")

#Plot
png("plot3.png",width = 480, height = 480, units = "px")

plot(pData$DATETIME,pData$Sub_metering_1,type="n",ylab = "Energy sub metering",xlab="")

lines(pData$DATETIME,pData$Sub_metering_1)
lines(pData$DATETIME,pData$Sub_metering_2,col="red")
lines(pData$DATETIME,pData$Sub_metering_3, col="blue")
legend("topright", lwd = 1, col = c("black", "red","blue"), legend = c("Sub_Metering_1", "Sub_Metering_2","Sub_Metering_3"))

dev.off()
