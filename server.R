library(shiny)
library(ggplot2)
data("diamonds")

# Define server logic required to generate and plot a random distribution
shinyServer(function(input, output) {

  datasetInput <- reactive(diamonds)

  output$summary <- renderPrint({
    summary(datasetInput())
  })
  
  output$table <- renderTable({
    x <- datasetInput()
    if (input$sort != " ") {
      sorder <- order(x[[input$sort]])
      x <- x[sorder, ]
    } 
    x[seq_len(input$obs), input$variables, drop=FALSE]
  })

  source("plot.R", local=TRUE)
  
})
