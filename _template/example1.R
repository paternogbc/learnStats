library(shiny)

### Page input
ui <- fluidPage(
 sliderInput(inputId = "num",
             label = "Choose a number",
             value = 25, min = 0, max = 1000),
             plotOutput(outputId = "hist")
)

server <- function(input, output) {
 output$hist <- renderPlot({
 ggplot2::qplot(rnorm(input$num))
 })
}

shinyApp(ui = ui, server = server)
