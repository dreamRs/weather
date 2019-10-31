#' @title Weather Icons Dependencies
#'
#' @description Explicitly load weathr icons dependencies in shiny or markdown.
#'
#' @export
#'
#' @name weather-dependencies
#'
#' @importFrom htmltools tags attachDependencies
#'
use_weather_icons <- function() {
  attachDependencies(
    x = tags$div(),
    value = weather_dependencies()
  )
}

#' @rdname weather-dependencies
#' @export
#' @importFrom htmltools htmlDependency
weather_dependencies <- function() {
  htmlDependency(
    name = "weather-icons",
    version = "2.0.10",
    src = list(href = "weather-icons", file = "assets"),
    package = "weather",
    stylesheet = c(
      "css/weather-icons.min.css",
      "css/weather-icons-wind.min.css"
    )
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
weather_icon <- function(name, size = "15px", color = "#000", ...) {
  wi <- attachDependencies(
    x = tags$i(
      class = paste("wi", find_icon(name)),
      style = sprintf("font-size:%s;", validateCssUnit(size)),
      style = sprintf("color:%s;", color),
      ...
    ),
    value = weather_dependencies()
  )
  class(wi) <- c(class(wi), "weather_icon")
  browsable(wi)
}


find_icon <- function(name) {
  if (length(name) > 1)
    stop("weather_icon: name must be of length one.", call. = FALSE)
  if (name %in% weather::weather_icon_df$icon) {
    if (!grepl(pattern = "^wi-", x = name) | grepl(pattern = "^(wi-towards-|wi-from-)", x = name)) {
      name <- paste("wi-wind", name)
    }
    return(name)
  }
  if (name %in% weather::weather_icon_df$name) {
    name <- weather::weather_icon_df$icon[which(weather::weather_icon_df$name == name)]
    if (!grepl(pattern = "^wi-", x = name) | grepl(pattern = "^(wi-towards-|wi-from-)", x = name)) {
      name <- paste("wi-wind", name)
    }
    return(name)
  }
  warning("weather_icon: icon not found.", call. = FALSE)
  return(name)
}



#' View all available icons
#'
#' @export
#' @importFrom htmltools browsable tag
#'
#' @examples
#' view_all_icons()
view_all_icons <- function() {
  browsable(tags$div(
    style = "margin: auto; padding: inherit;",
    lapply(
      X = weather::weather_icon_df$name,
      FUN = function(x) {
        tags$div(
          style = "display:inline-block; margin:5px;width:90px;height:100px;text-align:center;",
          weather_icon(x, size = "40px"),
          tags$br(),
          x
        )
      }
    )
  ))
}











