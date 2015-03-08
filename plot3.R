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

with(elect.sub, plot(1:2880,energy_sub, axes=F, type="n", ylab="Energy sub metering", xlab="", ylim=c(0,38)))
lines(elect.sub$Sub_metering_1, col="black", type="l")
lines(elect.sub$Sub_metering_2, col="red", type="l")
lines(elect.sub$Sub_metering_3, col="blue", type="l")
axis(1, c(1,1441,2880),c('Thu', 'Fri', 'Sat'))
axis(2, seq(0, 30, by = 10), seq(0, 30, by = 10)) 
box()
legend("topright", inset=.05, c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), fill=c('black', 'red', 'blue'))


