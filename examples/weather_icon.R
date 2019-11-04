weather_icon("day-sunny")
weather_icon("day-lightning")

weather_icon("meteor", size = "90px", color = "red")


# Usage in shiny
if (interactive()) {
  library(shiny)

  ui <- navbarPage(
    title = "App Title",
    tabPanel(
      title = "Plot", icon = weather_icon("sunrise"),
      actionButton("go", "a button", icon = weather_icon("day-rain"))
    ),
    tabPanel("Summary", icon = weather_icon("cloud")),
    tabPanel("Table", icon = weather_icon("tornado"))
  )

  server <- function(input, output, session) {

  }

  shinyApp(ui, server)
}


# Usage in shinydashboard
if (interactive()) {
  library(shiny)
  library(shinydashboard)
  library(weather)

  sidebar <- dashboardSidebar(
    sidebarMenu(
      menuItem("Weather", tabName = "weather", icon = weather_icon("day-rain"))
    )
  )

  body <- dashboardBody(
    fluidRow(
      infoBox(
        "Temperature", "17.2", "Subtitle", icon = weather_icon("thermometer")
      ),
      valueBox(
        "Sky clear", "cloud cover", icon = weather_icon("day-sunny")
      ),
      valueBox(
        "28%", "humidity", icon = weather_icon("raindrops")
      )
    )
  )

  server <- function(input, output) {

  }

  shinyApp(
    ui = dashboardPage(
      dashboardHeader(),
      sidebar,
      body
    ),
    server = server
  )
}
