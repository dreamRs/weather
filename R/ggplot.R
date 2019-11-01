

#' @importFrom grid gTree
weatherGrob <- function(x, y, weather, size = 1, alpha = 1, colour = "black"){
  gTree(x = x, y = y, weather = weather, size = size, colour = colour, cl = "weather_icon")
}

#' Custom grid Grob
#'
#' @inheritParams grid::makeContent
#'
#' @importFrom grid unit setChildren gList gpar
#' @importFrom grImport2 pictureGrob
#' @export
makeContent.weather_icon <- function(x) {
  weather_icons <- lapply(
    X = seq_along(x$weather),
    FUN = function(i) {
      pictureGrob(
        picture = weather_icons_grob[[x$weather[[i]]]],
        gpFUN = function(y) {
          if (!is.null(x$colour)) {
            gpar(fill = x$colour[i], col = x$colour[i])
          } else {
            gpar(fill = "black")
          }
        },
        x = x$x[i], y = x$y[i],
        width = x$size[i] * unit(1, "mm"),
        height = x$size[i] * unit(1, "mm"),
        distort = FALSE, ext = "gridSVG"
      )
    }
  )
  setChildren(x, do.call(gList, weather_icons))
}

#' @importFrom ggplot2 ggproto Geom aes
GeomWeather <- ggproto(
  "GeomWeather", Geom,
  required_aes = c("x", "y", "weather"),
  default_aes = aes(size = 10, weather = "day-sunny", colour = "black"),
  non_missing_aes = c("colour", "api"),
  setup_data = function(data, params) {
    data$weather <- as.character(data$weather)
    if (!is.null(params$api)) {
      data$weather <- match_api(data$weather, api = params$api)
    }
    data
  },
  draw_key = function(data, params, size) {
    weatherGrob(
      x = 0.5,
      y = 0.5,
      weather = data$weather,
      size = data$size,
      colour = data$colour
    )
  },
  draw_group = function(data, panel_scales, coord, api = NULL) {
    coords <- coord$transform(data, panel_scales)
    weatherGrob(
      x = coords$x,
      y = coords$y,
      weather = as.character(coords$weather),
      size = coords$size,
      colour = coords$colour
    )
  }
)


#' @title Geom Weather Icons
#'
#' @description Display weather icon in \code{ggplot2}.
#'
#' @inheritParams ggplot2::geom_point
#' @param api Name of the API to match icons.
#'
#' @note Use aesthetic \code{weather} to use an icon, values must
#'  be an icon available in \code{\link{weather_icon_names}}.
#'
#' @export
#' @importFrom ggplot2 layer
#'
#' @example examples/geom_weather.R
geom_weather <- function(mapping = NULL, data = NULL, api = NULL, stat = "identity",
                         position = "identity", na.rm = FALSE, show.legend = NA,
                         inherit.aes = TRUE, ...) {
  layer(
    geom = GeomWeather, mapping = mapping,  data = data, stat = stat,
    position = position, show.legend = show.legend, inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, api = api, ...)
  )
}

