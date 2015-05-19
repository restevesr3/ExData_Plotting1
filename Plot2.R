#Project 1
#Exploratory Data Analysis
#Plot 2

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

hpc<-read.table('./Project_1/household_power_consumption.txt', nrow=1000)  #Load 1000 rows

object.size(hpc)

memory_required<-function(no_columns, no_rows){
        x = no_columns * no_rows 
        print(x)
}

memory_required()

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

#---------------------[Plot 2]-------------------------------

png(filename = './Project_1/plot2.png', width = 480, height = 480)

plot(hpc_df$datetime, hpc_df$Global_active_power
     ,main='Global Active Power'
     ,type = 'l'
     ,ylab = 'Global Active Power (Kilowatts)'
     ,xlab = ''
)

dev.off()
