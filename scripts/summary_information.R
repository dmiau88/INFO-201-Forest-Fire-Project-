library("tidyverse")
library("dplyr")
library("stringr")

# Function for reading the dataset of California fires.
fires <- read.csv("..\\data\\California_Fire_Incidents.csv")
View(fires)

# Total number of fires in the dataset 

total_num_fires <- nrow(fires)

# Total number of features for the dataset

total_num_features <- ncol(fires)

# How many years does the dataset show?

featured_years <- fires %>% 
  mutate(yearDiff = max(ArchiveYear) - min(ArchiveYear)) %>% 
  filter(Started == min(Started))

featured_years <- head(featured_years$yearDiff, 1)

# How many unique counties are in the dataset? 
num_unique_counties <- length(unique(fires$Counties))

# What is the largest fire in the dataset?
largest_fire <- fires %>% 
  filter(AcresBurned == max(AcresBurned, na.rm = TRUE))

largest_fire <- head(largest_fire$Name, 1)

View(largest_fire)