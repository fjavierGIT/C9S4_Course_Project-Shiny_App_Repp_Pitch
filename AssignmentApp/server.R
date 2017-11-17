library(shiny)
library(colourpicker)
data("swiss")

# Define server logic required to draw a scatterplot
shinyServer(function(input, output) {
    
    output$warning <- renderText({
    # Checks if selected variables are the same, show warning if necessary
        var1 <- input$variable1;    var2 <- input$variable2
            if(identical(var1,var2)){
                HTML(paste("<font color=\"#FF0000\"><b>", "Selected Variables are the same!!", "</b></font>")) 
            } else {
                "Here you can see your model plot and summary"}
    })
    
    output$model <- renderPrint({
        # extract var from input$variable from ui.R
        var1 <- input$variable1;    var2 <- input$variable2
        meth <- input$meth
        x <- swiss[,var1];    y <- swiss[,var2]
                
        if(input$lines){
            if(identical(meth,'lm')){
                lm(y ~ x)
            } else {
                loess(y ~ x)}
        }
    })  
    
  output$plot1 <- renderPlot({
    # extract var from input$variable from ui.R
    var1 <- input$variable1;    var2 <- input$variable2
    col <- input$col;    meth <- input$meth
    x <- swiss[,var1];    y <- swiss[,var2]
    
    # draw the plot
    plot(x=x, y=y,
         xlab = var1, ylab = var2, col = col, col.axis = col,type="p")

    # Display lines only if lines checkbox is checked
    if(input$lines){
        if(identical(meth,'lm')){
            abline(lm(y ~ x), col = "darkblue", lwd = 3)
        } else {
            lines(lowess(y ~ x), col = "darkblue", lwd = 3)}
        }
})
})