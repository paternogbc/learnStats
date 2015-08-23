library(shiny);library(shinydashboard)

### Title:
header <- dashboardHeader(title = "Distributions")

### SideBar:
sidebar <- dashboardSidebar(
  sidebarMenu(
   menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
   menuItem("Graphs", tabName = "graphs", icon = icon("linux"))
  )
 )


### Dashboard:
body <- dashboardBody(

  ### Tabintes:
  tabItems(

   ### TAB 1 = dashboard:
   tabItem(tabName = "dashboard",

   fluidRow(
    # Sample size slider
    box(width = 4, sliderInput(inputId = "sample",
                    label = "Choose the sample size",
                    value = 25, min = 0, max = 1000)),
    # Mean slider:
    box(width = 4, sliderInput(inputId = "mean",
               label = "Choose the distribution mean",
               value = 50, min = 0, max = 500)),
    # Sd slider:
    box(width = 4, sliderInput(inputId = "sd",
               label = "Choose the standard deviation (sd)",
               value = 1, min = 0, max = 25)),

    box(width = 6, title = "Histogram",
        solidHeader = TRUE, status = "primary",
        plotOutput(outputId = "hist")),
    box(width = 6, title = "Points",
        solidHeader = TRUE, status = "warning",
        plotOutput(outputId = "boxplot"))
   )),

   # TAB 2 = dashboard:
   tabItem(tabName = "graphs",
           fluidRow(
           plotOutput(outputId = "boxplot2"))
   )
  )
 )

ui <- dashboardPage(header, sidebar, body)


