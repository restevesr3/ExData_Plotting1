#Project 2 Plot 1
#Exploratory data Analysis

#---------------------[Clear variables]-----------------------------------
rm(list=ls(all=TRUE))

#---------------------[Set working directory]-----------------------------

getwd()

setwd('F:\\Coursera\\Exploratory Data Analysis\\Week 2')

getwd()

#------------------------[Create project folder]-----------------------

if(!file.exists('./Project_2')){
  dir.create('./Project_2')
}

#-------------------------[Download file]----------------------------------

fileUrl = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
download.file(fileUrl, destfile = './Project_2/NationalEmissionInventory.zip')
unzip('./Project_2/NationalEmissionInventory.zip', exdir='./project_2')

#-------------------------[Load Data Source Code Classification]---------------

SCC<-readRDS('./Project_2/Source_Classification_Code.rds')

dim(SCC)

head(SCC)

str(SCC)


#-------------------------[Load Data Summary SCC PM25]--------------------------

NEI<-readRDS('./Project_2/summarySCC_PM25.rds')

dim(NEI)

head(NEI)

tail(NEI)

str(NEI)


#------------------------------[Question 1]---------------------------------------
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from 
#all sources for each of the years 1999, 2002, 2005, and 2008.

library(sqldf)

totalemissions<-sqldf('SELECT year, sum(Emissions) as TotalEmissions FROM NEI GROUP BY year;')

totalemissions


png('././Project_2/project_2_plot1.png', width=480, height = 480)

plot(totalemissions$year, 
     totalemissions$TotalEmissions/1000000,
     xlab = 'Year',
     ylab = 'Total Emissions PM2.5 (in Millions)',
     type = 'b',
     main = 'Total Emissions Of PM2.5 By Year\nUnited States (1999 to 2008)',
     col = 'red')

dev.off()