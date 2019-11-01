
#' Match API icon to Weather Icon
#'
#' @param name Name of the icon to find.
#' @param api Name of the API.
#'
#' @return a character vector.
#' @export
#'
#' @examples
#' # Default with darksky API
#' match_api("clear-day")
#' weather_icon(match_api("clear-day"))
match_api <- function(name,
                      api = c("darksky", "forecast-io",
                              "yahoo", "owm", "wu", "wmo4680")) {
  api <- match.arg(api)
  if (identical(api, "darksky"))
    api <- "forecast-io"
  icon_api <- sprintf("wi-%s-%s", api, name)
  ind <- match(table = weather::api_icons$api, x = icon_api)
  weather::api_icons$icon[ind]
}


