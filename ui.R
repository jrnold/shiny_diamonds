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

    conditionalPanel(
      condition = "input.view == 'raw'",

      h2("Raw Data"),
      
      #submitButton("Update View"),
      selectInput("variables", "Variables",
                  choices = colnames(diamonds),
                  selected = colnames(diamonds),
                  multiple = TRUE),
      
      sliderInput("obs", 
                  "Number of observations:", 
                  min = 0, 
                  max = nrow(diamonds),
                  value = 15),
      
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
                    "histogram", "boxplot")),
      
      
      h2("Aesthetics"),
      selectInput("x", "x-axis position",
                  choices = variables),
      
      selectInput("y", "y-axis position",
                  choices = variables),
      
      selectInput("color", "color (shapes)",
                  choices = variables),
      
      selectInput("fill", "color (fill)",
                  choices = variables),
      
      selectInput("shape", "shape",
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
