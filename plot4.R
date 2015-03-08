#Script for assignment 1 - Part 2

options(stringsAsFactors=FALSE)

#Libraries required
library(pastecs)
library(RODBC)
library(reshape2)
library(plyr)
library(stringr)

#Read the data
elect <- read.table("C:\\Users\\nvarana\\Desktop\\Training\\Exploratory_Analysis\\household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors=F)
elect$date <- as.Date(elect$Date, "%d/%m/%Y")
elect.sub <- elect[elect$date>="2007-02-01"&elect$date<="2007-02-02",]
elect.sub$Global_active_power <- as.numeric(elect.sub$Global_active_power)
elect.sub$wkday <- weekdays(elect.sub$date)
elect.sub$wkday <- substr(elect.sub$wkday, 1,3)

elect.sub$Sub_metering_1 <- as.numeric(elect.sub$Sub_metering_1)
elect.sub$Sub_metering_2 <- as.numeric(elect.sub$Sub_metering_2)
elect.sub$Sub_metering_3 <- as.numeric(elect.sub$Sub_metering_3)
elect.sub$sub_meter <- 1
elect.sub$sub_meter <- ifelse(elect.sub$Sub_metering_2!=0,2,elect.sub$sub_meter)
elect.sub$sub_meter <- ifelse(elect.sub$Sub_metering_3!=0,3,elect.sub$sub_meter)

elect.sub$energy_sub <- 0
elect.sub$energy_sub <- ifelse(elect.sub$sub_meter==1, elect.sub$Sub_metering_1,elect.sub$energy_sub) 
elect.sub$energy_sub <- ifelse(elect.sub$sub_meter==2, elect.sub$Sub_metering_2,elect.sub$energy_sub)
elect.sub$energy_sub <- ifelse(elect.sub$sub_meter==3, elect.sub$Sub_metering_3,elect.sub$energy_sub)  
elect.sub$energy_sub <- as.numeric(elect.sub$energy_sub)

elect.sub$Voltage <- as.numeric(elect.sub$Voltage)
elect.sub$Global_reactive_power <- as.numeric(elect.sub$Global_reactive_power)

#par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

elect.sub$Voltage <- as.numeric(elect.sub$Voltage)

par(mfrow = c(2, 2), mar = c(3.5, 4, 0, 0.5), oma = c(0, 0, 2, 0))

plot(1:2880, elect.sub$Global_active_power[1:2880], axes=F, type="l", ylab="Global Active Power (kilowatts)", xlab="", ylim=c(0,7))
axis(1, c(1,1441,2880),c('Thu', 'Fri', 'Sat'))
axis(2)
box()

plot(1:2880, elect.sub$Voltage[1:2880], axes=F, type="l", ylab="Voltage", xlab="datetime")
axis(1, c(1,1441,2880),c('Thu', 'Fri', 'Sat'))
axis(2)
box()

with(elect.sub, plot(1:2880,energy_sub, axes=F, type="n", ylab="Energy sub metering", xlab="", ylim=c(0,38)))
lines(elect.sub$Sub_metering_1, col="black", type="l")
lines(elect.sub$Sub_metering_2, col="red", type="l")
lines(elect.sub$Sub_metering_3, col="blue", type="l")
axis(1, c(1,1441,2880),c('Thu', 'Fri', 'Sat'))
axis(2, seq(0, 30, by = 10), seq(0, 30, by = 10)) 
box()
legend("topright", inset=.01, c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), fill=c('black', 'red', 'blue'))

plot(1:2880, elect.sub$Global_reactive_power[1:2880], axes=F, type="l", ylab="Global Reactive Power (kilowatts)", xlab="datetime", ylim=c(0,0.5))
axis(1, c(1,1441,2880),c('Thu', 'Fri', 'Sat'))
axis(2)
box()

