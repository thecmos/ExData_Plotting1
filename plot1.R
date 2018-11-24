##libraries that I will use
library(lubridate)
library(readr)
library(dplyr)
library(tidyr)

##read only  data of the first two days of February
pfeb<-subset(read.table("household_power_consumption.txt",header=TRUE,sep=";"),as.character(Date)=="1/2/2007"|as.character(Date)=="2/2/2007")
##Date converted from factor to date
pfeb_d<-mutate(pfeb,date=as.Date(dmy(as.character(Date))))

##plot the histogram as required and copy in png file
hist(as.numeric(as.character(pfeb_d$Global_active_power)),col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png", bg = "white",height=480,width=480)

dev.off()
