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
    n <- nrow(diamonds)
    x <- datasetInput()
    x <- x[ , input$variables, drop=FALSE]
    if (input$random) {
      cat("foo")
      x <- x[sample(seq_len(n), input$obs, replace=FALSE), , drop=FALSE]
    } else {
      x <- head(x, input$obs)
    }
    if (input$sort != " ") {
      sorder <- order(x[[input$sort]])
      x <- x[sorder, , drop=FALSE]
    }
    x
  })

  source("plot.R", local=TRUE)
  
})
