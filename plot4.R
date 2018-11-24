##libraries that I will use
library(lubridate)
library(readr)
library(dplyr)
library(tidyr)

##read only  data of the first two days of February
pfeb<-subset(read.table("household_power_consumption.txt",header=TRUE,sep=";"),as.character(Date)=="1/2/2007"|as.character(Date)=="2/2/2007")
##Date converted from factor to date
pfeb_d<-mutate(pfeb,date=as.Date(dmy(as.character(Date))))

##For the last three graphs I think it will be better to convert all numeric variables to numeric class and store them into the new data frame “pow”, and merge date and time in one variable
powdt<-data.frame()
for(i in 1:nrow(pfeb_d)){
for(j in 1:1){
powdt[i,j]<-paste(as.character(pfeb_d[i,j]),as.character(pfeb_d[i,j+1]))
}
for(j in 3:(ncol(pfeb_d)-1)){
powdt[i,j-1]<-parse_number(pfeb_d[i,j])
}}
##add names to columns of the data frame
names(powdt)<-c("date_time",names(pfeb_d[3:9]))
##plot first on screen, then copy to png, all the plots created before with minor changes, like avoiding borderline on legend box
##Prepare the plot device for four graphs, tow rows and two columns
par(mfrow=c(2,2))
##Plot the four graphs, one by one, by rows
plot(1:nrow(powdt),powdt$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="",xaxt="n")
axis(1,at=c(0,1441,2881),labels=c("Thu","Fri","Sat"))
plot(1:nrow(powdt),powdt$Voltage,type="l",ylab="Voltage",xlab="datetime",xaxt="n")
axis(1,at=c(0,1441,2881),labels=c("Thu","Fri","Sat"))
plot(1:nrow(powdt),powdt$Sub_metering_1,type="n",ylab="Energy sub metering",xlab="",xaxt="n")
points(1:nrow(powdt),powdt$Sub_metering_1,type="l")
points(1:nrow(powdt),powdt$Sub_metering_2,type="l",col="red")
points(1:nrow(powdt),powdt$Sub_metering_3,type="l",col="blue")
axis(1,at=c(0,1441,2881),labels=c("Thu","Fri","Sat"))
legend("topright",lty=1:1,col=c("black","red","blue"),bty="n",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

plot(1:nrow(powdt),powdt$Global_reactive_power,type="l",ylab="Global_reactive_power",xlab="datetime",xaxt="n")
axis(1,at=c(0,1441,2881),labels=c("Thu","Fri","Sat"))
dev.copy(png, file = "plot4.png", bg = "white",height=480,width=480)

dev.off()
