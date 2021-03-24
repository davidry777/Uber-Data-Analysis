month_group <- data_2014 %>%
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