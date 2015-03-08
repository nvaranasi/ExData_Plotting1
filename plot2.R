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
elect.sub$dttime <- paste(elect.sub$Date, elect.sub$Time, sep=" ")
elect.sub$dttime <- as.POSIXlt(elect.sub$dttime, "%d/%m/%Y %H:%M:%S")

plot(1:2880, elect.sub$Global_active_power[1:2880], axes=F, type="l", ylab="Global Active Power (kilowatts)", xlab="")
axis(1, c(1,1441,2880),c('Thu', 'Fri', 'Sat'))
axis(2)
box()



