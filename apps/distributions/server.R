library(shiny)
library(ggplot2)
library(shinydashboard)


server <- function(input, output) {

 ### Saving data:
 data <- reactive({
  data.frame(value = rnorm(mean = input$mean, n = input$sample, sd = input$sd),
             n = 1:input$sample)
 })

 ### First output "hist"
 output$hist <- renderPlot({
  ggplot(data(), aes(x = value, y = ..density..))+
   geom_histogram()+
   theme_bw()+
   geom_vline(xintercept = input$mean,
              colour = "red")
 })

 ### Second output "boxplot"
 output$boxplot <- renderPlot({
  ggplot(data(), aes(x = n, y = value))+
   geom_dotplot(binaxis = "y", stackdir = "center",
                dotsize = .2)
 })

 ### Second output "boxplot"
 output$boxplot2 <- renderPlot({
  ggplot(data(), aes(x = n, y = value))+
   geom_dotplot(binaxis = "y", stackdir = "center",
                dotsize = .2)
 })

}

