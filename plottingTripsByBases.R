ggplot(data_2014, aes(Base)) +
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