weather_icon("day-sunny")
weather_icon("day-lightning")

weather_icon("meteor", size = "90px", color = "red")


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
