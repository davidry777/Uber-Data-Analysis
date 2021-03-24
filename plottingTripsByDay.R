day_group <- data_2014 %>%
  group_by(day) %>%
    dplyr::summarize(Total = n())
datatable(day_group)

ggplot(day_group, aes(day, Total)) +
  geom_bar(stat = "identity", fill = "steelblue") +
    ggtitle("Trips Every Day") +
      theme(legend.position = "none") +
      scale_y_continuous(labels = comma)