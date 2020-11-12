library(dplyr)
library(ggplot2)

ggplot(data=avg_acres_burned) +
  geom_line(mapping = aes(x=ArchiveYear, y=avg_acres)) + 
  labs(
    title = "Average Acres Burned Each Year",
    x = "Year",
    y = "Average Acres"
  )