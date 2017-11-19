library(shiny)
library(datasets)
library(colourpicker)
data("swiss")

# Define UI for application that draws a scatterplot
shinyUI(fluidPage(
  # Application title
    
  titlePanel(title=div(img(src="32px-Flag_of_Switzerland.svg.png"), strong("SWISS DATA"))),
  
  # Input: Select an input for #1 variable selected 
  sidebarLayout(
    sidebarPanel(
        h4("INSTRUCTIONS:"), 
        helpText("The app takes advantage of the swiss data set.",br(),
            "1. User must select two variables.",br(),
                "2. A scatter plot of the variables will be shown.",br(),
                "3. There is the possibility to fit a line.",
                "When checked, two models are available: lm",
                "(Linear Model regression line) and loess ",
                "(loess line).",br(),
                "4. Results for selected method are printed.",br(),
                "5. Two distinct variables must be chosen,",
                "otherwise no output will be shown.",br(), 
                "6. Different line colours are available."),
        a(href="https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/swiss.html","More info on swiss data set"),
        br(),br(),
        selectInput(inputId = "variable1", label = strong("Variable #1"),
                choices = unique(names(swiss)),
                selected = "Fertility"),
    
    # Input: Select an input for number #2 variable selected 
    selectInput(inputId = "variable2", label = strong("Variable #2"),
                choices = unique(names(swiss)),
                selected = "Agriculture"),
    
    #Input: Select if user wants fitted line
    checkboxInput(inputId = "lines", label = strong("Overlay fit line"), value = FALSE),
    
    #Input: Method
    conditionalPanel(condition = "input.lines == true",
    selectInput(inputId = "meth", label = strong("Select fit method"), 
                choices = c("lm","loess"),
                selected = "lm"),
    
    #Input: Line colour
    colourInput("col", "Select line colour", "red", palette = "limited", showColour = "background")
        )
    ),
    
    # Show the generated plot for choosen variables
    mainPanel(
        # Panel Title
        h2("Swiss Fertility and Socioeconomic Indicators Data (1888) with fit line"),
        
        # htmlOutput: Formatted text for warning
        h3(htmlOutput("warning", container = span)),
        
        conditionalPanel(condition="input.variable1 != input.variable2",
            plotOutput(outputId = "plot1"),
            verbatimTextOutput("model")
            ),
        hr(),
        p(), 
        helpText(HTML('<p>Swiss Flag By Marc Mongenet <a href="https://commons.wikimedia.org/wiki/File%3AFlag_of_Switzerland.svg"> via Wikimedia Commons</a></p>'))
    )
    )
))

