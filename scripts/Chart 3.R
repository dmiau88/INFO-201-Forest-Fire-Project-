library(plotly)
library(ggplot2)
library(tidyverse)
library(ggrepel)


county_fires_plot <- ggplot(data = avg_time_contain) +
  geom_smooth(mapping = aes(x = ArchiveYear, y = avg_day_diff)) +
  labs(title = "Average Number of days it took to contain fires from 2013-2019", x = "Year", y = "Average Number of Days")

ggplotly(county_fires_plot)
