library(dplyr)
library(ggplot2)

ggplot(data=total_num_fires) + 
  geom_col(mapping = aes(x=ArchiveYear, y=total_num_fires)) +
  labs(
    title = "Total Number of Fires Each Year",
    x = "Year",
    y = "Number of Fires"
  )