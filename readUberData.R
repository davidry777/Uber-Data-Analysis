apr_data <- read.csv(file='Uber-dataset/uber-raw-data-apr14.csv')
may_data <- read.csv(file='Uber-dataset/uber-raw-data-may14.csv')
jun_data <- read.csv(file='Uber-dataset/uber-raw-data-jun14.csv')
jul_data <- read.csv(file='Uber-dataset/uber-raw-data-jul14.csv')
aug_data <- read.csv(file='Uber-dataset/uber-raw-data-aug14.csv')
sep_data <- read.csv(file='Uber-dataset/uber-raw-data-sep14.csv')

data_2014 <- rbind(apr_data, may_data, jun_data, jul_data, aug_data, sep_data)

data_2014$Date.Time <- as.POSIXct(data_2014$Date.Time, format = "%m/%d/%Y %H:%M:%S")

data_2014$Time <- format(as.POSIXct(data_2014$Date.Time, format = "%m/%d/%Y %H:%M:%S"), format="%H:%M:%S")

data_2014$Date.Time <- ymd_hms(data_2014$Date.Time)

data_2014$day <- factor(day(data_2014$Date.Time))
data_2014$month <- factor(month(data_2014$Date.Time, label = TRUE))
data_2014$year <- factor(year(data_2014$Date.Time))
data_2014$dayofweek <- factor(wday(data_2014$Date.Time, label = TRUE))

data_2014$hour <- factor(hour(hms(data_2014$Time)))
data_2014$minute <- factor(minute(hms(data_2014$Time)))
data_2014$second <- factor(second(hms(data_2014$Time)))