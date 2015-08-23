library(shiny);library(shinydashboard)

### Title:

header <- dashboardHeader(title = "Sums of Squares")

### SideBar:
sidebar <- dashboardSidebar(
  sidebarMenu(
   menuItem("Graphs", tabName = "graphs", icon = icon("dashboard")),
   menuItem("Raw Data", tabName = "data", icon = icon("linux"))
  )
 )


### Dashboard:
body <- dashboardBody(


 fluidRow(column(12, includeMarkdown("open.md"))),
  ### Tabintes:

  tabItems(

   ### TAB 1 = dashboard:
   tabItem(tabName = "graphs",

   fluidRow(

    # Sample size slider
    box(width = 4, title = "Parameters",
        solidHeader = TRUE, status = "primary",

    sliderInput(inputId = "sample",
                    label = "Sample size",
                    value = 20, min = 10, max = 30),
    sliderInput(inputId = "slope",
               label = "Regression slope",
               value = 1, min = -2, max = 2,step = .5),
    # Sd slider:
    sliderInput(inputId = "SD",
               label = "Standard deviation",
               value = 1, min = 0, max = 20)),

    mainPanel(

     box(width = 6,
         title = "Original Regression",
         solidHeader = TRUE, status = "primary",
         plotOutput(outputId = "reg"),
         tableOutput(outputId = "anova")),


     box(width = 6,title = "Sums of Squares Graphs",
         solidHeader = TRUE, status = "primary",
     tabsetPanel(type = "tabs",
                 tabPanel("Total", plotOutput("total")),
                 tabPanel("Regression", plotOutput("regression")),
                 tabPanel("Error", plotOutput("error")),
                 tabPanel("Variance Partition", plotOutput(("variance")))

     )
     )
    )

   )),

   # TAB 2 = dashboard:
   tabItem(tabName = "data",
           fluidRow(
            box(width = 4, solidHeader = TRUE, status = "primary",
                title = "Raw Data",
             dataTableOutput(outputId = "data")))
   )
  )
 )

ui <- dashboardPage(header, sidebar, body)


