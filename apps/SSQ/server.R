library(shiny)
library(ggplot2)
library(shinydashboard)
library(data.table)
library(grid)


server <- function(input, output) {

 ### Saving data:
 Rawdata <- reactive({
  slope <- input$slope
  SD <- input$SD
  sample <- input$sample
  x <- 1:sample
  y <- slope * (x+rnorm(n = sample, mean = 1, sd = SD ))
  mod <- lm(y ~ x, data.frame(y,x))
  ypred <- predict(mod)
  Rawdata <- data.frame(y, x, ypred)
 })

 SSdata <- reactive({
  dat <- Rawdata()
  Y <- mean(dat$y)
  mod <- lm(y ~ x, dat)
  ypred <- predict(mod)
  dat$ypred <- ypred
  SST <- sum((dat$y - Y)^2)
  SSE <- sum((dat$y - ypred)^2)
  SSA <- SST - SSE
  SSQ <- data.frame(SS = c("SS total","SS regression","SS error"),
                    value = as.numeric(c(SST, SSA, SSE)/SST)*100)
  SSQ$SS <- factor(SSQ$SS, as.character(SSQ$SS))
  SSdata <- data.frame(SS = factor(SSQ$SS, as.character(SSQ$SS)),
                    value = as.numeric(c(SST, SSA, SSE)/SST)*100)

 })


 ### First output "graphs"
 output$plot <- renderPlot({
  cols <- c("#619CFF", "#00BA38", "#F8766D")

  ### Graphs:
  g4 <- ggplot(SSdata(), aes(y = value, x = SS, fill = SS))+
   geom_bar(stat = "identity")+
   scale_fill_manual(values = cols)+
   theme(axis.title = element_text(size = 20),
         axis.text  = element_text(size = 0),
         panel.background=element_rect(fill="white",colour="black")) +
   ylab("% of variance")

  g2 <- ggplot(Rawdata(), aes(x = x, y = y))+
   geom_point(size=3) + geom_smooth(method= "lm", se = F,
                                    colour = "black")+
   geom_segment(xend = Rawdata()[,2], yend = Rawdata()[,3],
                colour = "#F8766D")+
   theme(axis.title = element_text(size = 20),
         axis.text  = element_text(size = 18),
         panel.background=element_rect(fill="white",colour="black"))+
   ggtitle("SS error")

  g1 <- ggplot(Rawdata(), aes(x=x,y=y))+
   geom_point(size=3) +
   geom_segment(xend = Rawdata()[,2], yend = mean(Rawdata()[,1]),
                colour = "#619CFF")+
   geom_hline(yintercept = mean(Rawdata()[,1]))+
   theme(axis.title = element_text(size = 20),
         axis.text  = element_text(size = 18),
         panel.background=element_rect(fill="white",colour="black"))+
   ggtitle("SS total")


  # SS regression:
  g3 <- ggplot(Rawdata(), aes(x=x,y=y))+
   geom_point(alpha=0)+
   geom_smooth(method= "lm", se = F, colour = "black")+
   geom_hline(yintercept = mean(Rawdata()[,1]))+
   geom_segment(aes(x=x,y=ypred), xend = Rawdata()[,2],
                yend = mean(Rawdata()[,1]),
                colour = "#00BA38")+
   theme(axis.title = element_text(size = 20),
         axis.text  = element_text(size = 18),
         panel.background=element_rect(fill="white",colour="black"))+
   ggtitle("SS regression")
  gridExtra::grid.arrange(g1, g3, g2, g4, ncol = 2)

 })

 ### Second output "boxplot"
 output$anova <- renderPrint({
  anova(lm(y ~ x, Rawdata()))
 })
 output$summary <- renderPrint({
  summary(lm(y ~ x, Rawdata()))
 })

}

