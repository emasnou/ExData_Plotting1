# plot2.R
# Project week 1:Exploratory Data Analysis.
# 
# Data file description:

# Source: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# Description: Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years. Different electrical quantities and some sub-metering values are available.

# The following descriptions of the 9 variables in the dataset are taken from the UCI web site:

#   Date: Date in format dd/mm/yyyy
#   Time: time in format hh:mm:ss
#   Global_active_power: household global minute-averaged active power (in kilowatt)
#   Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
#   Voltage: minute-averaged voltage (in volt)
#   Global_intensity: household global minute-averaged current intensity (in ampere)
#   Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
#   Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
#   Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.




##############
# Function DataExists
##############
#' Checks for data file and downloads it if missing.
#' \code{DataExists} Checks for data file and raises an error if missing.
#' 
#' This function checks for data file in data/household_power_consumption.txt
#' If file does not exists and error is raised.
#'  
#' 
#' @return TRUE
#' 

DataExists <- function() 
{
    if ( ! file.exists("data/household_power_consumption.txt") )
        stop ("Error There is no data file data/household_power_consumption.txt")
    TRUE
}

##############
# Function LoadData
##############
#' Loads the data from datafile into a dataframe.
#' \code{LoadData} Loads the data from datafile into a dataframe.
#' 
#' This function loads the data contained in datafile and returns a dataframe with all the information.
#' 
#'  
#' 
#' @return Dataframe with data contained in file.
#' 

LoadData <- function()
{
    # Read the file ; separated.
    DF = read.delim("data/household_power_consumption.txt",header = TRUE,sep = ";", stringsAsFactors=FALSE)
    # concat Date and Time
    DF$Date = paste(DF$Date,DF$Time)
    # Convert strings with dates to Datetime classes
    DF$Date = strptime(DF$Date,"%d/%m/%Y %H:%M:%S")
    DF$Time = NULL
    # Select only requested data.
    DF = subset(DF, Date >= "2007-02-01" & Date < "2007-02-03")
    # Convert strings into numeric
    DF$Global_active_power = as.double(DF$Global_active_power)
    DF$Global_reactive_power = as.double(DF$Global_reactive_power)
    DF$Voltage = as.double(DF$Voltage)
    DF$Global_intensity = as.double(DF$Global_intensity)
    DF$Sub_metering_1 = as.double(DF$Sub_metering_1)
    DF$Sub_metering_2 = as.double(DF$Sub_metering_2)
    DF$Sub_metering_3 = as.double(DF$Sub_metering_3)
    
    
    
    DF
}

########################
#' MAIN
########################

FILE = DataExists()
DF = LoadData()

# Draw plot

# Create png file
png("plot2.png")

#Draw
plot(DF$Date,DF$Global_active_power, 
     type="l", 
     ylab = "Global Active Power (Kilowatts)", 
     xlab="")
dev.off()
