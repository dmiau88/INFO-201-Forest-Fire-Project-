library(tidyverse)
library(shiny)
library(lintr)
library(styler)
library(plotly)

fires <- read.csv("https://raw.githubusercontent.com/dmiau88/INFO-201-Forest-Fire-Project-/main/data/California_Fire_Incidents.csv")

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

# Chart 2 - Average Acres Burned Per Year Per County

avg_acres_burned <- fires %>%
  group_by(ArchiveYear, Counties) %>%
  summarize(avg_acres = round(mean(AcresBurned, na.rm = TRUE)))

chart2 <- ggplot(data = avg_acres_burned) +
  geom_line(mapping = aes(x = ArchiveYear, y = avg_acres, color = Counties)) +
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
  geom_col(mapping = aes(x=ArchiveYear, y=total_num_per_year,
                         fill = Counties)) +
  labs(
    title = "Total Number of Fires Each Year (2013-2018)",
    x = "Year",
    y = "Number of Fires"
  )
print(chart3)


server <- function(input, output) {
  output$fires_per_month <- renderPlotly({
    fires_per_month_updated <- fires_per_month %>%
             filter(ArchiveYear == input$fires_year_id)
    
    chart1 <- ggplot(data = fires_per_month_updated) +
      geom_col(mapping = aes(x = Month, y = num_fires_per_month),
                             fill = input$color_id) +
      labs(title = "Number of Fires Per Month Each Year (2013-2018)", 
           x = "Month", y = "Number of Fires")
  })
  
  output$avg_acres_burned <- renderPlotly ({
    avg_acres_burned_updated <- avg_acres_burned %>%
            filter(Counties == input$county_id)
    
    chart2 <- ggplot(data = avg_acres_burned_updated) +
      geom_line(mapping = aes(x = ArchiveYear, y = avg_acres),
                color = input$color_id2) +
      labs(
        title = "Average Acres Burned Each Year (2013-2018)",
        x = "Year",
        y = "Average Acres")
  })
  
  output$total_num_fires<- renderPlotly ({
    total_num_fires_updated <- total_num_fires %>%
      filter(Counties == input$num_fires_county_id)
    
    chart3 <- ggplot(data = total_num_fires_updated) +
      geom_col(mapping = aes(x = ArchiveYear, y = total_num_per_year),
                             fill = input$color_id3) +
      labs(
        title = "Total Number of Fires Each Year (2013-2018)",
        x = "Year",
        y = "Number of Fires"
      )
  })
}
  
  
# chosen_year <- reactive({
#   if (is.na(input$fires_year_id)) {
#     2018
#   } else {
#     input$fires_year_id
#   }
# })
# 
# chosen_county <- reactive({
#   if (is.na(input$county_id)) {
#     "Los Angeles"
#   } else{
#     input$county_id
#   }
# })