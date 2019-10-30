#' Shiny resource
#'
#' @importFrom shiny addResourcePath
#'
#' @noRd
.onLoad <- function(...) {
  shiny::addResourcePath("weather-icons", system.file("assets", package = "weather"))
}
