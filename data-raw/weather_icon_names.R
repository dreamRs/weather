## code to prepare `weather_icon_names` dataset goes here


weather_icon_names <- list.files(path = "inst/assets/svg2/")
weather_icon_names <- gsub(
  pattern = "wi-(.*)\\.svg",
  replacement = "\\1",
  x = weather_icon_names
)



usethis::use_data(weather_icon_names)
