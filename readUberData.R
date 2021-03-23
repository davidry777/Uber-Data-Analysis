apr_data <- read.csv(file='Uber-dataset/uber-raw-data-apr14.csv')
may_data <- read.csv(file='Uber-dataset/uber-raw-data-may14.csv')
jun_data <- read.csv(file='Uber-dataset/uber-raw-data-jun14.csv')
jul_data <- read.csv(file='Uber-dataset/uber-raw-data-jul14.csv')
aug_data <- read.csv(file='Uber-dataset/uber-raw-data-aug14.csv')
sep_data <- read.csv(file='Uber-dataset/uber-raw-data-sep14.csv')

data2014 <- rbind(apr_data, may_data, jun_data, jul_data, aug_data, sep_data)
