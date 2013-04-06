library(shiny)
library(ggplot2)
data("diamonds")
variables <- c(" ", colnames(diamonds))

# Define UI for application that plots random distributions 
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Diamonds Data"),
  
  sidebarPanel(
    h2("Data View"),
    radioButtons("view", "",
                 choices =
                 list("Raw data" = "raw",
                      "Summary stats" = "summary",
                      "Plot" = "plot")),

    submitButton("Update View"),
    
    conditionalPanel(
      condition = "input.view == 'raw'",


      
      selectInput("variables", "Variables",
                  choices = colnames(diamonds),
                  selected = colnames(diamonds),
                  multiple = TRUE),

      numericInput("obs", "Number of observations to view:", 10,
                   min = 1, max = nrow(diamonds)),

      checkboxInput("random", "Random sample"),
      
      selectInput("sort", "Sort",
                  choices = c(" ", colnames(diamonds)),
                  multiple = FALSE)
      
      ),
    conditionalPanel(
      condition = "input.view == 'plot'",

      h2("Geom"),
      
      selectInput("geom", "Geometric object",
                  choices =
                  c("auto",
                    "point", "line", "bar", "jitter",
                    "histogram", "boxplot"),
                  selected = "auto"),
      
      
      h2("Aesthetics"),
      selectInput("x", "x-axis position",
                  choices = variables,
                  selected = "carat"),
      
      selectInput("y", "y-axis position",
                  choices = variables,
                  selected = "price"),
      
      selectInput("color", "color (shapes)",
                  choices = variables),
      
      selectInput("fill", "color (fill)",
                  choices = variables),
      
      selectInput("shape", "shape",
                  choices = variables),
      
      selectInput("size", "size",
                  choices = variables),

      h2("Coordinates"),
      checkboxInput("logy", "y-axis log scale"),
      checkboxInput("logx", "x-axis log scale")
      )
    ),
  
  mainPanel(
    conditionalPanel(
      condition = "input.view == 'summary'",
      verbatimTextOutput("summary")
      ),
    conditionalPanel(
      condition = "input.view == 'raw'",
      tableOutput("table")
      ),
    conditionalPanel(
      condition = "input.view == 'plot'",
      plotOutput("plot")
      )
    )
  ))
