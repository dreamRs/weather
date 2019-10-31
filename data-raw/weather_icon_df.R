## code to prepare `weather_icon_df` dataset goes here



# Packages ----------------------------------------------------------------

library(rvest)

wi <- read_html(x = "https://erikflowers.github.io/weather-icons/")

weather_icon_df <- data.frame(
  icon = html_text(html_nodes(x = wi, css = ".icon-name")),
  unicode = html_text(html_nodes(x = wi, css = ".icon_unicode")),
  stringsAsFactors = FALSE
)
weather_icon_df <- weather_icon_df[!duplicated(weather_icon_df$icon), ]
# weather_icon_df$dup <- duplicated(weather_icon_df$icon) | duplicated(weather_icon_df$icon, fromLast = TRUE)


setdiff(weather_icon_df$icon, paste0("wi-", weather_icon_names))


weather_icon_df$name <- gsub(pattern = "^wi-", replacement = "", x = weather_icon_df$icon)

head(weather_icon_df)

usethis::use_data(weather_icon_df)
