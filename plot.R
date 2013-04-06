dataInput <- reactive({diamonds})

output$plot <- renderPlot({
  args <- list(data = dataInput())
  for (i in c("x", "y", "color", "fill", "shape", "size")) {
    if (input[[i]] != " ") {
      args[[i]] <- as.name(input[[i]])
      }
  }
  args[["geom"]] <- input$geom
  
  if (input$logx && input$logy) {
    args[["log"]] <- "xy"
  } else if (input$logx) {
    args[["log"]] <- "x"      
  } else if (input$logy) {
    args[["log"]] <- "y"
  }
  
  print(do.call(qplot, args))
})

output$summary <- renderPrint({
  summary(dataInput())
})
