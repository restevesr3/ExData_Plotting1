#Project_2_Plot_4
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

#-------------------------[Question 4]-----------------------------------------
#Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

names(SCC)

coal_combustion<-sqldf("SELECT year, sum(Emissions) AS TotalEmissions FROM NEI
                       WHERE SCC IN (SELECT SCC FROM SCC WHERE [Short.Name] LIKE '%Coal%')
                       GROUP BY
                       year;
                       " )


coal_combustion

#-------------------[Plot data]-------------------------

png('./Project_2/project_2_plot4.png',   width=480, height=480)

qplot(year, 
      TotalEmissions, 
      data = coal_combustion, 
      main = 'Total Emission From Coal Combustion-Related Sources \nUnited States (1999-2008)',
      ylab = 'Total Emssions',
      xlab = 'Year'
) + geom_line(color='red', size=1.5)

dev.off()

