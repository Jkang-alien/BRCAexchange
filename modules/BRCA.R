library(shiny)
library(pool)
library(glue)
library(tidyverse)

source("helpers.R")

dataBrcaExchange <- readRDS("data/BRCAexchange.rds")

brcaUI <- function(id, label = "brca") {
  ns <- NS(id)
  tagList(
    radioButtons(ns("gene"), label = "Gene",
                 choices = list("BRCA1" = "NM_007294.3", "BRCA2" = "NM_000059.3")),
    textInput(ns("variant"), label = "Variant",
              value = "c.1105G>A"),

    actionButton('search', "Search Variant"),

    fluidRow(
      box(title = "Report", status = "primary",
          tableOutput(ns("brcaExchange"))))
    )
  
}

brca <- function(input, output, session) {


  output$brcaExchange <-  renderTable({
      input_HGVS_cDNA <- paste0(input$gene, ":", input$variant)
      dataBrcaExchange %>%
        filter(HGVS_cDNA == input_HGVS_cDNA) %>%
        select(HGVS_cDNA)
    })

}

