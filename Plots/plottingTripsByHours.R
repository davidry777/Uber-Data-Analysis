hour_data <- data_2014 %>%
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