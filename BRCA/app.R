## Only run examples in interactive R sessions

source("helpers.R")
#BRCAexchange <- readRDS("BRCA/data/BRCAexchange.rds")


if (interactive()) {
    
    ui <- fluidPage(
        sidebarLayout(
            sidebarPanel(
                fileInput("file1", "Choose tsv File"),
                tags$hr()
            ),
            mainPanel(
                tableOutput("content1"),
                tableOutput("content2")
            )
        )
    )
    
    server <- function(input, output) {
        output$content1 <- renderTable({
            inFile <- input$file1
            if (is.null(inFile))
                return(NULL)
            
            df_input <- make.df.from.input(inFile$datapath)
            gene_info(df_input)
        })
        
        output$content2 <- renderTable({
            inFile <- input$file1
            
            if (is.null(inFile))
                return(NULL)
            
            df_input <- make.df.from.input(inFile$datapath)
            read_info(df_input)
        })
    }
    
    shinyApp(ui, server)
}