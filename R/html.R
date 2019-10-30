
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

#' @export
#' @importFrom htmltools attachDependencies tags browsable
weather_icon <- function(name, size = "40px", ...) {
  wi <- attachDependencies(
    x = tags$i(
      class = paste0("wi wi-", name),
      style = sprintf("font-size:%s;", validateCssUnit(size)),
      ...
    ),
    value = weather_dependencies()
  )
  class(wi) <- c(class(wi), "weather_icon")
  browsable(wi)
}


