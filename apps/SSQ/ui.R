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
    box(width = 4, sliderInput(inputId = "sample",
                    label = "Sample size",
                    value = 20, min = 10, max = 30)),
    # Slope slider:
    box(width = 4, sliderInput(inputId = "slope",
               label = "Regression slope",
               value = 1, min = -2, max = 2,step = .5)),
    # Sd slider:
    box(width = 4, sliderInput(inputId = "SD",
               label = "Standard deviation",
               value = 1, min = 0, max = 20)),

    box(width = 6,
        title = "Regression Sums of Squares",
        solidHeader = TRUE, status = "primary",
        plotOutput(outputId = "plot")),
    box(width = 6,
           title = "Anova Table",
           solidHeader = TRUE, status = "primary",
           tableOutput(outputId = "anova")),
    box(width = 6,
        title = "Summary",
        solidHeader = TRUE, status = "primary",
        tableOutput(outputId = "summary"))
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


