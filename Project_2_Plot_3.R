#Project_2_Plot_3
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

#--------------------[Question 3]----------------------------
#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
#which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
#Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make
#a plot answer this question.

type_emissions<-sqldf("SELECT type, year, sum(Emissions) AS TotalEmissions 
                      FROM NEI
                      WHERE fips = '24510'
                      GROUP BY 
                      type, 
                      year;"
)

type_emissions

#--------------------------[Load ggplot2 library]--------------------------
library(ggplot2)


#--------------------------[Plot graph]------------------------------------

png('./Project_2/project_2.plot3.png',    width=480, height =480)

qplot(year, 
      TotalEmissions, 
      data=type_emissions, 
      color=type, 
      xlab = 'Year',
      ylab = 'Total Emissions of PM2.5',
      main = 'Yearly Emissions Totals for Baltimore City, Maryland'
) + geom_line(size = 1.5)

dev.off()

