#Project_2_Plot_2
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


#--------------------------------[Question 2]--------------------------------------
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
#from 1999 to 2008? Use the base plotting system to make a plot answering this question.


baltimorecity<-sqldf("SELECT year, sum(Emissions) as TotalEmission FROM NEI Where fips = '24510' GROUP BY year;")

head(baltimorecity)

png('./Project_2/project_2_plot2.png', width=480, height =480)

plot(baltimorecity$year, 
     baltimorecity$TotalEmission/1000,
     xlab = 'Year',
     ylab = 'Total Emissions PM2.5 (in thousands)',
     main = 'Baltimore City \nTotal Emissions from PM2.5 by Year',
     type = 'b',
     col = 'red'
     
)

dev.off()
