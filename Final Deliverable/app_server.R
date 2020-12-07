library(tidyverse)
library(shiny)
library(lintr)
library(styler)
library(plotly)

fires <- read.csv("../data/California_Fire_Incidents.csv")

#Chart 1 - Number of Fires Per Month Each Year

fires_per_month <- fires %>% 
  mutate(Month = strftime(Started,"%m")) %>% 
  group_by(ArchiveYear, Month) %>% 
  summarize(num_fires_per_month = n())
  
chart1 <- ggplot(data = fires_per_month) +
  geom_col(mapping = aes(x = Month, y = num_fires_per_month, fill = ArchiveYear)) +
  labs(title = "Number of Fires Per Month Each Year (2013-2018)", x = "Month", y = "Number of Fires")

ggplotly(chart1)
print(chart1)

#Chart 2 - Average Acres Burned Per Year Per County

avg_acres_burned <- fires %>%
  group_by(ArchiveYear, Counties) %>%
  summarize(avg_acres = round(mean(AcresBurned, na.rm = TRUE)))

chart2 <- ggplot(data=avg_acres_burned) +
  geom_line(mapping = aes(x=ArchiveYear, y=avg_acres, fill = Counties)) + 
  labs(
    title = "Average Acres Burned Each Year (2013-2018)",
    x = "Year",
    y = "Average Acres"
  )
print(chart2)

#Chart 3 - Total Number of Fires Per Year Per County 

total_num_fires <- fires %>%
  group_by(ArchiveYear, Counties) %>%
  summarize(total_num_per_year = n())

chart3 <- ggplot(data=total_num_fires) + 
  geom_col(mapping = aes(x=ArchiveYear, y=total_num_per_year, fill = Counties)) +
  labs(
    title = "Total Number of Fires Each Year (2013-2018)",
    x = "Year",
    y = "Number of Fires"
  )
print(chart3)

server <- function(input, output) {
  output$
}