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

hist(elect.sub$Global_active_power, col="red", ylim=c(0,1200), main="Global Active Power", ylab="Frequency", xlab="Global Active Power (kilowatts)")

parent <- "C:\\Users\\nvarana\\Desktop\\Training\\R_prog_coursera\\data\\"
min <- 1
max <- 332

complete <- function(directory, id=1:332){
  file.path <- paste(parent,"\\", directory,"\\", sep="")  
  all.monitors <- NULL
  for(i in id){
    if(i<min) next
    if(i>332) break
    file <- i
    file <- ifelse(i<10, paste("00",i,sep=""), file)
    file <- ifelse(i>=10&i<100, paste("0",i,sep=""), file)
    monitor <- read.csv(paste(file.path, file, ".csv", sep=""))
    nobs <- nrow(monitor[!is.na(monitor$sulfate)&!is.na(monitor$nitrate),])
    all.monitors <- rbind(all.monitors, c(monitor$ID[1], nobs))
 }
 colnames(all.monitors) <- c("id", "nobs")
 return(data.frame(all.monitors))
}