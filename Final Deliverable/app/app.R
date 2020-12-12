library(tidyverse)
library(shiny)
library(ggplot2)
library(plotly)
library(RColorBrewer)
library(shinythemes)

source("ui.R")
source("app_server.R")


shinyApp(ui = ui, server = server)