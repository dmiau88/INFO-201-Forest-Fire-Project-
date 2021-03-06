library("tidyverse")
library("dplyr")
library("stringr")

# Read the csv of California fires.
fires <- read.csv("../data/California_Fire_Incidents.csv")
View(fires)

# Average number of acres burned per year
avg_acres_burned <- fires %>%
  group_by(ArchiveYear) %>%
  summarize(avg_acres = round(mean(AcresBurned, na.rm = TRUE)))

# Average number of fires per county from 2013-2019
avg_num_fires_counties <- fires %>%
  group_by(Counties) %>%
  summarize(avg_fires_county = round(mean(n(), na.rm = TRUE)))

# Average amount of days it took to contain each fire per year
fires <- fires %>%
  mutate(
    Extinguished = substr(Extinguished, 1, 10),
    Started = substr(Started, 1, 10)
  ) %>%
  mutate(
    Extinguished = as.Date(Extinguished, "%Y-%m-%d"),
    Started = as.Date(Started, "%Y-%m-%d")
  )

avg_time_contain <- fires %>%
  mutate(Date_Difference = Extinguished - Started) %>%
  filter(Date_Difference >= 0) %>%
  group_by(ArchiveYear) %>%
  summarize(avg_day_diff = round(mean(Date_Difference, na.rm = TRUE)))

# Total amount of days it took to contain all fires each year.
sum_time_contain <- fires %>%
  mutate(Date_Difference = Extinguished - Started) %>%
  filter(Date_Difference >= 0) %>%
  group_by(ArchiveYear) %>%
  summarize(sum_day_diff = round(sum(Date_Difference, na.rm = TRUE)))

# Number of fires per year
total_num_fires <- fires %>%
  group_by(ArchiveYear) %>%
  summarize(total_num_per_year = n())

# County with highest number of fires per year
county_highest_fires <- fires %>%
  group_by(ArchiveYear, Counties) %>%
  summarize(county_num_per_year = max(n())) %>%
  filter(county_num_per_year == max(county_num_per_year))
