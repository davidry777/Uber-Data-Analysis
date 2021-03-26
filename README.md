# Uber Data Analysis
 
## Description
This data analysis project is meant to analyze raw data of Uber pickups in New York City from April to September 2014. The plotting of datasets is done through the R programming language, using the following libraries: ggplot2, ggthemes, lubridate, dplyr, tidyr, DT, and scales.

This [dataset](https://www.kaggle.com/fivethirtyeight/uber-pickups-in-new-york-city) was published by FiveThirtyEighty, who obtained the data from the NYC Taxi & Limousine Commission (TLC). There are six raw data files, separated into months:
* `uber-raw-data-apr14.csv`
* `uber-raw-data-may14.csv`
* `uber-raw-data-jun14.csv`
* `uber-raw-data-jul14.csv`
* `uber-raw-data-aug14.csv`
* `uber-raw-data-sep14.csv`

Each file contains the following columns:
* `Date/Time` : The date and time of the Uber pickup
* `Lat` : The latitude of the Uber pickup
* `Lon` : The longitude of the Uber pickup
* `Base` : The TLC base company code affiliated with the Uber pickup

## Analysis Preparation
### Installing Libraries
```library(ggplot2)
library(ggthemes)
library(lubridate)
library(dplyr)
library(tidyr)
library(DT)
library(scales)
setwd("~/Documents/GitHub/Uber-Data-Analysis")
```
### Establishing Colors
`colors = c("#CC1011", "#665555", "#05a399", "#cfcaca", "#f5e840", "#0683c9", "#e075b0")`
### Data Loading and Preparation
```apr_data <- read.csv(file='Uber-dataset/uber-raw-data-apr14.csv')
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

head(data_2014)
```
<img width="721" alt="Screen Shot 2021-03-25 at 9 55 23 AM" src="https://user-images.githubusercontent.com/42628566/112512243-6ec16400-8d50-11eb-9ef5-51c4ee581db2.png">

## Analysis of Trips by Hours in a Day
### Code:
```hour_data <- data_2014 %>%
  group_by(hour) %>%
  dplyr::summarize(Total = n())
datatable(hour_data)

ggplot(hour_data, aes(hour, Total)) +
  geom_bar(stat = "identity", fill = "steelblue", color = "red") +
    ggtitle("Trips Every Hour") +
      theme(legend.position = "none") +
      scale_y_continuous(label = comma)
      
month_hour <- data_2014 %>%
  group_by(month, hour) %>%
    dplyr::summarize(Total = n())

ggplot(month_hour, aes(hour, Total, fill = month)) +
  geom_bar(stat = "identity") +
    ggtitle("Trips by Hour and Month") +
      scale_y_continuous(label = comma)
```
### Bar Plots for Trips Every Hour in a Day

![Trips Every Hour](https://github.com/davidry777/Uber-Data-Analysis/blob/main/Images/Rplot01.png)

![Trips Every Hour By Month](https://github.com/davidry777/Uber-Data-Analysis/blob/main/Images/Rplot02.png)

Based on these plots, we observe that the highest number of trips occur in the 17-18th hour, which in Eastern Time is 5-6 pm. We can assume that the reason for this high number of trips is because 5-6 pm in NYC is the time that adult business workers leave the office.

## Analysis of Trips by Days in a Week
### Code:
```day_group <- data_2014 %>%
  group_by(day) %>%
    dplyr::summarize(Total = n())
datatable(day_group)

ggplot(day_group, aes(day, Total)) +
  geom_bar(stat = "identity", fill = "steelblue") +
    ggtitle("Trips Every Day") +
      theme(legend.position = "none") +
      scale_y_continuous(labels = comma)

day_month_group <- data_2014 %>%
  group_by(month, day) %>%
    dplyr::summarize(Total = n())

ggplot(day_month_group, aes(day, Total, fill = month)) + 
  geom_bar(stat = "identity") +
    ggtitle("Trips by Day and Month") +
      scale_y_continuous(labels = comma) +
      scale_fill_manual(values = colors)
```
### Bar Plots for Trips Every Day of the Month

![Trips Every Day](https://github.com/davidry777/Uber-Data-Analysis/blob/main/Images/Rplot03.png)

![Trips Every Day By Month](https://github.com/davidry777/Uber-Data-Analysis/blob/main/Images/Rplot04.png)

Based on these plots, we observe that the 30th day of the month had the highest number of trips. It's also interesting to point out that majority of these trips occurred on April 30th. 

## Analysis of Trips by Months in a Year
### Code:
```month_group <- data_2014 %>%
  group_by(month) %>%
    dplyr::summarize(Total = n())
datatable(month_group)

ggplot(month_group, aes(month, Total, fill = month)) + 
  geom_bar( stat = "identity") +
    ggtitle("Trips by Month") +
      theme(legend.position = "none") +
      scale_y_continuous(labels = comma) +
      scale_fill_manual(values = colors)

month_weekday <- data_2014 %>%
  group_by(month, dayofweek) %>%
    dplyr::summarize(Total = n())

ggplot(month_weekday, aes(month, Total, fill = dayofweek)) + 
  geom_bar(stat = "identity", position = "dodge") +
    ggtitle("Trips by Day and Month") +
      scale_y_continuous(labels = comma) +
      scale_fill_manual(values = colors)
```
### Bar Plots for Trips Every Month
![Trips Every Month](https://github.com/davidry777/Uber-Data-Analysis/blob/main/Images/Rplot05.png)

![Trips Every Month By Day](https://github.com/davidry777/Uber-Data-Analysis/blob/main/Images/Rplot06.png)

Looking at these plots, we observe that the most popular month for trips is September. Furthermore, each of the days in September are higher than the days for the other months. A reason to this could be that September is a very popular month for tourism, leading to a greater number of trips.

## Analysis of Trips by Bases
### Code:
```ggplot(data_2014, aes(Base)) +
  geom_bar(fill = "darkblue") +
    scale_y_continuous(labels = comma) +
    ggtitle("Trips By Bases")
    
ggplot(data_2014, aes(Base, fill = month)) +
  geom_bar(position = "dodge") +
    scale_y_continuous(labels = comma) +
    ggtitle("Trips by Bases and Month") +
    scale_fill_manual(values = colors)

ggplot(data_2014, aes(Base, fill = dayofweek)) +
  geom_bar(position = "dodge") +
    scale_y_continuous(labels = comma) +
    ggtitle("Trips by Bases and DayofWeek") +
    scale_fill_manual(values = colors)
```
### Bar Plots for Trips Every Base
![Trips Every Base](https://github.com/davidry777/Uber-Data-Analysis/blob/main/Images/Rplot07.png)

![Trips Every Base By Month](https://github.com/davidry777/Uber-Data-Analysis/blob/main/Images/Rplot08.png)

![Trips Every Base By Day of Week](https://github.com/davidry777/Uber-Data-Analysis/blob/main/Images/Rplot09.png)

When observing these plots, we can see that the most popular Uber base for trips is B02617, otherwise known as Weiter. Base Weiter had a greater number of trips in September, therefore connecting the base to tourism in NYC. We can also see that the trips per day in each base are consistent, with Thursday mostly popular for trips.

## Heat maps
### Code:
```day_and_hour <- data_2014 %>%
  group_by(day, hour) %>%
    dplyr::summarize(Total = n())
datatable(day_and_hour)

ggplot(day_and_hour, aes(day, hour, fill = Total)) +
  geom_tile(color = "white") +
    ggtitle("Heat Map by Hour and Day")

ggplot(day_month_group, aes(day, month, fill = Total)) +
  geom_tile(color = "white") +
    ggtitle("Heat Map by Month and Day")

ggplot(month_weekday, aes(dayofweek, month, fill = Total)) +
  geom_tile(color = "white") +
    ggtitle("Heat Map by Month and Day of Week")

month_base <-  data_2014 %>%
  group_by(Base, month) %>%
    dplyr::summarize(Total = n()) 

day0fweek_bases <-  data_2014 %>%
  group_by(Base, dayofweek) %>%
    dplyr::summarize(Total = n()) 

ggplot(month_base, aes(Base, month, fill = Total)) +
  geom_tile(color = "white") +
    ggtitle("Heat Map by Month and Bases")

ggplot(day0fweek_bases, aes(Base, dayofweek, fill = Total)) +
  geom_tile(color = "white") +
    ggtitle("Heat Map by Bases and Day of Week")
```
    
![Heat map 1](https://github.com/davidry777/Uber-Data-Analysis/blob/main/Images/Rplot10.png)

![Heat map 2](https://github.com/davidry777/Uber-Data-Analysis/blob/main/Images/Rplot11.png)

![Heat map 3](https://github.com/davidry777/Uber-Data-Analysis/blob/main/Images/Rplot12.png)

![Heat map 4](https://github.com/davidry777/Uber-Data-Analysis/blob/main/Images/Rplot13.png)

![Heat map 5](https://github.com/davidry777/Uber-Data-Analysis/blob/main/Images/Rplot14.png)

## Visualizations of Rides in NYC
### Code:
```ggplot(data_2014, aes(x=Lon, y=Lat)) +
  geom_point(size=1, color = "blue") +
    scale_x_continuous(limits=c(min_long, max_long)) +
      scale_y_continuous(limits=c(min_lat, max_lat)) +
        theme_map() +
          ggtitle("NYC MAP BASED ON UBER RIDES DURING 2014 (APR-SEP)")

ggplot(data_2014, aes(x=Lon, y=Lat, color = Base)) +
  geom_point(size=1) +
    scale_x_continuous(limits=c(min_long, max_long)) +
      scale_y_continuous(limits=c(min_lat, max_lat)) +
        theme_map() +
          ggtitle("NYC MAP BASED ON UBER RIDES DURING 2014 (APR-SEP) by BASE")
```
![NYC Visualization 1](https://github.com/davidry777/Uber-Data-Analysis/blob/main/Images/Rplot15.png)

![NYC Visualization 2](https://github.com/davidry777/Uber-Data-Analysis/blob/main/Images/Rplot16.png)

## Conclusion
Based off the data plots and visualizations, we can conclude that Uber is a popular consumer service for both NYC civilians and tourism, therefore making Uber the more successful transportation service in NYC, compared to other services like the NYC Taxi Service.
