
#' @importFrom htmltools htmlDependency
weather_dependencies <- function() {
  htmlDependency(
    name = "weather-icons",
    version = "2.0.10",
    src = list(href = "weather-icons", file = "assets"),
    package = "weather",
    stylesheet = "css/weather-icons.min.css"
  )
}


#' Weather Icons
#'
#' @param name Name of the icon.
#' @param size Size (in pixels).
#' @param color Color of the icon.
#' @param ... Named attributes to be applied to the tag.
#'
#' @return an HTMl tag
#' @export
#' @importFrom htmltools attachDependencies tags browsable validateCssUnit
#'
#' @example examples/weather_icon.R
weather_icon <- function(name, size = "40px", color = "#000", ...) {
  wi <- attachDependencies(
    x = tags$i(
      class = paste0("wi wi-", name),
      style = sprintf("font-size:%s;", validateCssUnit(size)),
      style = sprintf("color:%s;", color),
      ...
    ),
    value = weather_dependencies()
  )
  class(wi) <- c(class(wi), "weather_icon")
  browsable(wi)
}


