#Download the file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "./powerData.zip")
unzip("./powerData.zip")

#Read in data
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

png("plot1.png",width = 480, height = 480, units = "px")
hist(as.numeric(pData$Global_active_power),col="red",breaks=13,xlab="Global Active Power (kilowatts)",
     main="Global Active Power")
dev.off()