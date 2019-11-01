## code to prepare `api_icons` dataset goes here

library(rvest)
library(stringi)
library(data.table)

wi <- read_html(x = "https://erikflowers.github.io/weather-icons/api-list.html")


api <- html_text(html_nodes(x = wi, css = "li"))
api <- stri_trim_both(api)
api <- stri_replace_all_regex(str = api, pattern = ",\\s+", replacement = ",")
api <- stri_replace_all_regex(str = api, pattern = "\\.\\s+", replacement = ",")
api <- stri_split_regex(str = api, pattern = ":|\\s")
api <- lapply(api, function(x) {
  x[x != ""]
})

api_dt <- as.data.table(transpose(api))
setnames(api_dt, c("api", "icon"))
api_dt[, c("api", "api2") := tstrsplit(api, split = ",")]
api_dt <- rbind(api_dt[, list(api, icon)], api_dt[!is.na(api2), list(api = api2, icon)])
api_dt

api_icons <- as.data.frame(api_dt)

usethis::use_data(api_icons)
