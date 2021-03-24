day_group <- data_2014 %>%
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