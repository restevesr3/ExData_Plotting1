#Project_2_Plot_6
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

SCC[1:5, 1:2]

SCC[1:5, 6:10]
#-------------------------[Load Data Summary SCC PM25]--------------------------

NEI<-readRDS('./Project_2/summarySCC_PM25.rds')

dim(NEI)

head(NEI)

tail(NEI)

str(NEI)

#----------------[Load sqldf library]-----------------------------------------------

library(sqldf)


#--------------------------[Load ggplot2 library]--------------------------
library(ggplot2)


#---------------------------[Question 6]----------------------------------------
#Compare emissions from motor vehicle sources in Baltimore City with emissions 
#from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?

motor_vehicles_Baltimore_Los_Angeles<-sqldf('SELECT year,fips, sum(Emissions) AS TotalEmissions FROM NEI
                                WHERE SCC IN (
                                SELECT SCC FROM SCC WHERE [Short.Name] like "%Motor%")
                                AND
                                FIPS in("24510", "06037")
                                GROUP BY
                                year,
                                fips;')

motor_vehicles_Baltimore_Los_Angeles

png('./Project_2/project_2_plot6.png', width=480,  height=480)

qplot(year, 
      TotalEmissions,
      data = motor_vehicles_Baltimore_Los_Angeles,
      xlab='year',
      ylab='Total Emissions',
      main='Comparison Of Emissions From Motor Vehicles Sources\nBaltimore City vs. Los Angeles County\n(1999-2008)',
      color = fips
) + geom_line(size = 1.5)

dev.off()