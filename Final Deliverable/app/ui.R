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
    h1(strong("Questions we are looking to answer")),
    p("The main questions we would like to answer in this project are 
      1. What is the number of fires that occurred each month from 2013-2018?
      2. What areas in California were most affected by forest fires?
      3. What was the total number of fires each year in each county?"),
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
      h2("Finding the number of fires occurring each month in each year"),
      p("Below is my interactive visualization showing the total greenhouse gas emissions for each country"),
      plotlyOutput(outputId = "fires_per_month"),
      p("The reason why I chose to include this chart was to provide an individualized snapshot of each country's
        greenhouse gas emissions. Compared to the large data chart (even when you use dplyr to parse some of the
        data, it can get a little overwhelming. While the data visualilzations does not include functionality to
        compare countries in terms of greenhouse gas emissions, it still helps to provide a visual illustration
        of the data")
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
      h2("Finding the average number of acres burned per year by wildfires"),
      p("Below is my interactive visualization showing the total greenhouse gas emissions for each country"),
      plotlyOutput(outputId = "avg_acres_burned"),
      p("The reason why I chose to include this chart was to provide an individualized snapshot of each country's
        greenhouse gas emissions. Compared to the large data chart (even when you use dplyr to parse some of the
        data, it can get a little overwhelming. While the data visualilzations does not include functionality to
        compare countries in terms of greenhouse gas emissions, it still helps to provide a visual illustration
        of the data")
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
      h2("Finding the total number of fires per year based on counties"),
      p("Below is my interactive visualization showing the total greenhouse gas emissions for each country"),
      plotlyOutput(outputId = "total_num_fires"),
      p("The reason why I chose to include this chart was to provide an individualized snapshot of each country's
        greenhouse gas emissions. Compared to the large data chart (even when you use dplyr to parse some of the
        data, it can get a little overwhelming. While the data visualilzations does not include functionality to
        compare countries in terms of greenhouse gas emissions, it still helps to provide a visual illustration
        of the data")
    )
  )
)

#Summary Page

SummaryPage <- tabPanel(
  "Summary Takeaways",
  mainPanel(
    h1("Summary"),
    p("Welcome to my assignment 4! For my assignment, I have chosen to track the variables of greenhouse gases,
      coal, and CO2 using a data set compiled by Our World in Data (link below). Through working with
      the data, I have looked to find relevant values and trends within the data that will allow me
      to put together a greater picture about climate change over time, and how differnet countries
      (my work focuses on the USA), has impacted climate change throughout history."),
    p(a("Our World in Data", href = "https://ourworldindata.org/co2-and-other-greenhouse-gas-emissions")),
    p(strong("Below are 5 relevant data points about climate change that I calculated
             using the raw data compiled by Our World in Data:")),
    p("The difference between the USA CO2 emissions from coal in the years 2000 and 2010 was 159.117 million tonnes"),
    p("The year where the USA's share of global CO2 emissions was the greatest was in 2000"),
    p("In the most recent documented year for this metric (2014), the USA's greenhouse gas
      emissions per capita was 19.135 tonnes"),
    p("After charging the USA's greenhouse gas emissions each year, I found that the greatest emissions
      came in 2007, at 6601.13 million tonnes of carbon dioxide equivalents."),
    p("In 1990, the United States had the greatest cumulative share of global CO2 emissions at 30.716% of global emissions.
      This emissions number was also the greatest cumulative share of global CO2 emissions within the entire datset.")
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

