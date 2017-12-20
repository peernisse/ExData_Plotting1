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
png("plot2.png",width = 480, height = 480, units = "px")
plot(pData$DATETIME,pData$Global_active_power,type="n",ylab = "Global Active Power (kilowatts)",xlab="")
lines(pData$DATETIME,pData$Global_active_power)
dev.off()

