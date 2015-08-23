library(shiny);library(shinydashboard)

### Title:
header <- dashboardHeader(title = "Sums of Squares")

### SideBar:
sidebar <- dashboardSidebar(
  sidebarMenu(
   menuItem("Graphs", tabName = "graphs", icon = icon("dashboard")),
   menuItem("Summary", tabName = "summary", icon = icon("linux"))
  )
 )


### Dashboard:
body <- dashboardBody(

  ### Tabintes:
  tabItems(

   ### TAB 1 = dashboard:
   tabItem(tabName = "graphs",

   fluidRow(
    # Sample size slider
    box(width = 4, sliderInput(inputId = "sample",
                    label = "Sample size",
                    value = 20, min = 10, max = 100)),
    # Mean slider:
    box(width = 4, sliderInput(inputId = "slope",
               label = "Regression slope",
               value = 1, min = -5, max = 5)),
    # Sd slider:
    box(width = 4, sliderInput(inputId = "SD",
               label = "Standard deviation",
               value = 1, min = 0, max = 25)),

    box(width = 10,height = 16,
        title = "Regression Sums of Squares",
        solidHeader = TRUE, status = "primary",
        plotOutput(outputId = "plot"))
   )),

   # TAB 2 = dashboard:
   tabItem(tabName = "summary",
           fluidRow(
            box(width = 12,solidHeader = TRUE, status = "primary",
                title = "Anova",
             verbatimTextOutput(outputId = "anova")),
            box(width = 12,solidHeader = TRUE, status = "primary",
                title = "summary",
             verbatimTextOutput(outputId = "summary")))
   )
  )
 )

ui <- dashboardPage(header, sidebar, body)


