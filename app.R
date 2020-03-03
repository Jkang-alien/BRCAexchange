## Only run examples in interactive R sessions

source("helpers.R")
BRCAexchange <- readRDS("data/BRCAexchange.rds")


if (interactive()) {
    
    ui <- fluidPage(
        sidebarLayout(
            sidebarPanel(
                fileInput("file1", "Choose tsv File"),
                tags$hr()
            ),
            mainPanel(
                tableOutput("1"),
                tableOutput("content2")
            )
        )
    )
    
    server <- function(input, output) {
        
        inFile <- reactive(input$file1)
        df_input <- reactive(make.df.from.input(inFile()$datapath))
        locus <- reactive(df_input()$Locus)
        
        lapply (1:1, function(i) {
            output[[i]] <- renderTable({
                read_info(df_input() %>%
                              filter(Locus == locus()[i]))
            })
        })

        output$content2 <- renderTable({
            if (is.null(inFile()))
                return(NULL)
            read_info(df_input())
        })
    }
    
    shinyApp(ui, server)
}