#Project 1
#Exploratory Data Analysis
#Plot 1

#-----------------[Set Working Directory]-----------------------
setwd('I:\\Coursera\\Exploratory Data Analysis\\Week 1')

getwd()

#------------------[Create Project Directory if Applicable]------------------
if(!file.exists('./Project_1')){
        dir.create('./Project_1')
}

#-------------------------[Download Data Set]--------------------------------------

fileUrl<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(fileUrl, destfile= './Project_1/Electric_Power_Consumption.zip')
unzip('./Project_1/Electric_Power_Consumption.zip', exdir='./Project_1')

#-------------------------[Estimate Memory Size of Object]------------------------------
#The dataset has 2,075,259 rows and 9 columns. First calculate a rough estimate of how much memory the dataset will require in memory before reading into R. Make sure your computer has enough memory (most modern computers should be fine).

#We will only be using data from the dates 2007-02-01 and 2007-02-02. One alternative is to read the data from just those dates rather than reading in the entire dataset and subsetting to those dates.

#You may find it useful to convert the Date and Time variables to Date/Time classes in R using the strptime() and as.Date() functions.

#Note that in this dataset missing values are coded as ?

hpc<-read.table('./Project_1/household_power_consumption.txt', nrow=1000)  #Load 1000 rows

object.size(hpc)

memory_required<-function(no_columns, no_rows){
        x = no_columns * no_rows 
        print(x)
}

memory_required(9, 2075259)
#---------------------------[Import Dataset]-------------------------

#import 1000 rows to be able to format the dataset
hpc<-read.table('./Project_1/household_power_consumption.txt', nrow=1000, sep=';', header=TRUE)

#remove dataset in case it is not properly formatted.
rm(hpc)

#--------------------------------[Verify Memory size]----------------------
object.size(hpc)

#--------------------------------[Inspect Dataset]-----------------------------

dim(hpc)

head(hpc)

rm(hpc)

#--------------------------[Load complete dataset]----------------------------

hpc<-read.table('./Project_1/household_power_consumption.txt', sep = ';', header=TRUE, stringsAsFactor=FALSE)

dim(hpc)

head(hpc)

str(hpc)


hpc<-transform(hpc,
               Date = as.POSIXct(Date, format='%d/%m/%Y')
)

str(hpc)

head(hpc)


hpc_df<-subset(hpc, Date >='2007-02-01' & Date <= '2007-02-02' )

dim(hpc_df)

head(hpc_df)

rm(hpc)

head(hpc_df, n=10)

hpc_df[,3]

hpc_df<-transform(hpc_df,
                  Global_active_power = as.numeric(Global_active_power),
                  Global_reactive_power = as.numeric(Global_reactive_power),
                  Voltage = as.numeric(Voltage),
                  Global_intensity = as.numeric(Global_intensity),
                  Sub_metering_1 = as.numeric(Sub_metering_1),
                  Sub_metering_2 = as.numeric(Sub_metering_2)
                  
)
str(hpc_df)

head(hpc_df, n=3)

hpc_df$datetime<-paste(hpc_df$Date, hpc_df$Time)

head(hpc_df, n=3)

str(hpc_df)

hpc_df<-transform(hpc_df,
                  datetime = as.POSIXct(datetime, format = '%Y-%m-%d %H:%M:%S')
                  
)

head(hpc_df, n=3)

str(hpc_df)

hpc_df$day<-format(hpc_df$datetime, '%a')

str(hpc_df)

unique(hpc_df$Date)

unique(hpc_df$day)

hpc_df[1:10,c(1,3,11)]

tail(hpc_df)

class(hpc_df$datetime)

#------------------[Plot 1]--------------------------------

#Open Graphics Device
png('./Project_1/plot1.png', width = 480, height = 480)  

hist(hpc_df$Global_active_power,
     main = 'Global Active Power',
     xlab = 'Global Active Power (Kilowatts)',
     ylab = 'Frequency',
     col='red1'
)

#Close Graphics Device
dev.off()

#--------------------[Dump Data set]----------------------------

rm(list=ls(all=TRUE))


