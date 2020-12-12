library(shiny)
library(tidyverse)
library(plotly)
library(lintr)
library(styler)
library(RColorBrewer)
library(shinythemes)

fires <- read.csv("https://raw.githubusercontent.com/dmiau88/INFO-201-Forest-Fire-Project-/main/data/California_Fire_Incidents.csv")


#Intro Page

Introduction <- tabPanel(
  "Introduction",
  mainPanel(
    h1(strong("Background and Context")),
    p("Welcome to our final deliverable! Throughout this entire quarter, 
      our group has been working on a project relating to the Calfiornian 
      forest fires. We are interested in this topic because it is very 
      relevant to current events. While many of our group members experienced
      the result of the fires near the end of the summer in Seattle, one of
      our teammates, Andrew Wong, actually lived 30 minutes away from raging
      forest fires in California. Our project topic of forest fires also 
      relates to the overarching conversation around climate change and fossil
      fuel usage. As the nationwide forest fires continue to rage, we hope to
      find patterns not only in the impact of these fires, but also in their
      causes."),
    img(src='forest_fires.png', height = "130px" , width = "400px"),
    h1(strong("Questions We Are Looking to Answer")),
    p(strong("The main questions we would like to answer in this project are:")),
    p("1. What is the number of fires that occurred each month from 2013-2018?"),
    p("2. What areas in California were most affected by forest fires?"),
    p("3. What was the total number of fires each year in each county?"),
    h1(strong("Our Dataset")),
    p(a("Link to Dataset", href = "https://www.kaggle.com/ananthu017/california-wildfire-incidents-20132020")),
    p("In order to answer the questions above, we utilized a specific dataset
      relating to Californian forest fires from Kaggle.com. The data is compiled
      from the California Department of Forestry and Fire Protection. This set
      has lots of data regarding where wildfires have occurred (county name,
      latitude/longitude), and contains details about when the wildfire has 
      started. There are currently 1637 observations/rows in the data set
      and 40 features/columns in the data set. We felt that this data set
      was the most accessible in finding the data that we wanted to explore.")
  ))

#Chart 1 Page

ChartPage1 <- tabPanel(
  "Visual Chart 1",
  sidebarLayout(
    sidebarPanel(
      p("Select your viewing options!"),
      selectInput("fires_year_id",
                  label = h3("Year"),
                  choices = fires$ArchiveYear,
                  selected = "2013"
      ),
      selectInput("color_id",
                  label = h3("Color"),
                  choices = brewer.pal(8, "Set2")
      )
    ),
    mainPanel(
      h2("Number of Fires Each Month, Per Year"),
      p("Below is our interactive visualization showing the 
        number of fires each month per year."),
      plotlyOutput(outputId = "fires_per_month"),
      p("The reason why we chose to include this chart is to further organize 
        our data into a month-by-month snapshot. By illustrating the
        month-to-month impacts of wildfires (in this case the number of 
        fires each month, we were able to see that the general trend in the 
        number of wildfires each month, per year was that a majority of
        wildfires happen in July. Not only can the viewer see trends in which
        months have the most wildfires, they can also see the specific number
        of wildfires that occured each month. A shocking statistic that we
        found was that in July of 2016, there were 45 recorded wildfires.
        However, in July of 2017, there were 112 recorded wildfires.")
    )
  )
)

#Chart 2 Page

ChartPage2 <- tabPanel(
  "Visual Chart 2",
  sidebarLayout(
    sidebarPanel(
      p("Select your viewing options!"),
      selectInput("county_id",
                  label = h3("County"),
                  choices = fires$Counties,
                  selected = "Los Angeles"
      ),
      selectInput("color_id2",
                  label = h3("Color"),
                  choices = brewer.pal(8, "Set2")
      )
    ),
    mainPanel(
      h2("Average Number of Acres Burned, Per Year"),
      p("Below is our interactive visualization showing the 
        average number of acres burned per year."),
      plotlyOutput(outputId = "avg_acres_burned"),
      p("The reason why we chose to include this chart is to localize the trends
        we originally found in our exploratory analysis. By providing the viewer
        to choose different counties, they can see the local impacts of wildfires
        across California. By using a line chart, we can easily spot trends in
        the data. Furthermore, the viewer can also see the specific numbers of
        average acres burned for each year. A relevant data point that we found 
        using this visualization was that for San Bernadino County, California's
        largest county, there was a spike in average acres burned in 2016, where
        the average number of acres burned was 11,114.")
    )
  )
)


#Chart 3 Page

ChartPage3 <- tabPanel(
  "Visual Chart 3",
  sidebarLayout(
    sidebarPanel(
      p("Select your viewing options!"),
      selectInput("num_fires_county_id",
                  label = h3("County"),
                  choices = fires$Counties,
                  selected = "Los Angeles"
      ),
      selectInput("color_id3",
                  label = h3("Color"),
                  choices = brewer.pal(8, "Set2")
      )
    ),
    mainPanel(
      h2("Total Number of Fires Each Year, Per County"),
      p("Below is our interactive visualization showing the total number
        of fires each year, categorized by counties in Calfornia."),
      plotlyOutput(outputId = "total_num_fires"),
      p("Similar to the last chart, this chart provides the viewer with 
        an opportunity to see the impact of wildfires on localized California
        counties. We understand that the total number of fires does not illustrate
        the whole picture of the impact of wildfires on each county, that is why
        we wanted to include this chart in conjunction with the previous one
        (average acres burned). This way the viewer can cross-check the acres
        burned data with the number of fires data to create a greater picture
        of the impact of wildfires on California counties. A relevant data point
        that we found was that for Los Angeles county, in 2017 there was almost 
        double the amount of fires than in 2016, the total number of fires 
        increasing from 7 to 13.")
    )
  )
)

#Summary Page

SummaryPage <- tabPanel(
  "Summary Takeaways",
  mainPanel(
    h1("Summary Takeaways "),
    p(strong("Below are 3 relevant data points about the California Wildfires 
             that we observed:")),
    p("Throughout the data frame, the month with the highest average number of 
      fires was July at just over 59 fires. Each year besides 2013 and 2019
      had July as the month with the most fires."),
    p("One of the largest counties in California, Los Angeles county had a large
      spike in average acres burned in 2018, going from 2,399 average acres
      burned in 2017 to 12,779 average acres burned in 2018."),
    p("In Riverside County, between the years of 2014 and 2016 the total number
      of fires was below 10 per year. However, After a spike to 52 fires in 2017,
      Riverside County has had 25 fires in 2018 and 33 fires in 2019. This 
      massive uptick in the total number of fires was alarming to us."),
    p(strong("Thank you for viewing our project! We hope you were able to see
             key takeaways about the California Wildfires."))
  ))

#Fluid Page Code

ui <- fluidPage(theme = shinytheme("cerulean"),
  h3("INFO 201 Final Deliverable: California Forest Fires"),
  h3("Created by Andrew Wong, Kyle Tsang, Ibrahim Yusef, Daniel Miau"),
  navbarPage(
    inverse = TRUE,
    "California Forest Fires",
    Introduction,
    ChartPage1,
    ChartPage2,
    ChartPage3,
    SummaryPage
  )
)

