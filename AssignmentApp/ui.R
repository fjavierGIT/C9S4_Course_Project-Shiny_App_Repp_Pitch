library(shiny)
library(datasets)
library(colourpicker)
data("swiss")

# Define UI for application that draws a scatterplot
shinyUI(fluidPage(
  # Application title
  titlePanel("SWISS DATA"),
  
  # Input: Select an input for #1 variable selected 
  sidebarLayout(
    sidebarPanel(
        p("Swiss Fertility and Socioeconomic Indicators (1888) Data"),
        selectInput(inputId = "variable1", label = strong("Variable #1"),
                choices = unique(names(swiss)),
                selected = "Fertility"),
    
    # Input: Select an input for number #2 variable selected 
    selectInput(inputId = "variable2", label = strong("Variable #2"),
                choices = unique(names(swiss)),
                selected = "Agriculture"),
    
    #Input: Background colour
    colourInput("col", "Select points colour", "red", palette = "limited", showColour = "background"),
    
    #Input: Select if user wants fitted line
    checkboxInput(inputId = "lines", label = strong("Overlay trend line"), value = FALSE),
    
    #Input: Method
    conditionalPanel(condition = "input.lines == true",
    selectInput(inputId = "meth", label = strong("Select fit method"), 
                choices = c("lm","loess"),
                selected = "lm")),
    br(),
    helpText("INSTRUCTIONS: User must select two variables.",
         "A scatter plot of the variables will be shown.",
         "There is the possibility to fit a line.",
         "When checked, two models are available: lm",
         "(Linear Model) and loess. Results for selected",
         "method are printed. Two distinct variables must be" ,
         "chosen, otherwise no output will be shown.", 
         "Different point colour can be selected.")
    
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
        
        # htmlOutput: Formatted text for warning
        h2(htmlOutput("warning", container = span)),
        
        conditionalPanel(condition="input.variable1 != input.variable2",
            plotOutput(outputId = "plot1", height = "300px"),
            tabPanel("Model", verbatimTextOutput("model"))
        )
    )
  )
))

