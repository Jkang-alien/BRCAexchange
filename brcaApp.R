library(shiny)
library(shinydashboard)
library(dplyr)
library(tibble)
library(pool)
library(rlang)
library(DBI)
library(readr)
library(RSQLite)
library(tidyverse)

source("modules/BRCA.R")
#source("modules/breast-DCIS.R")

ui <- dashboardPage(
  dashboardHeader(title = "BRCA"),
  dashboardSidebar(
    sidebarMenu(id = "tabs",
                menuItem("brca", tabName = "brca")
    )
  ),
  dashboardBody(
    tabItems(
      tabItem("brca", brcaUI("brca"))
      )
  )
)


server <- function(input, output, session) {
  callModule(brca, "brca")
}

shinyApp(ui, server)