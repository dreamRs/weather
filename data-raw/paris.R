## code to prepare `paris` dataset goes here

# Fake data

paris <- data.frame(
  hour = seq(as.POSIXct("2017-04-11"), by = "hour", length.out = 24),
  temperature = c(5, 3, 2, 2, 3, 3, 5, 6, 6, 10, 11, 11,
                  14, 14, 15, 17, 16, 16, 14, 11, 9, 9, 8, 6),
  weather = c("night-clear", "night-clear", "night-alt-cloudy",
              "night-alt-cloudy", "night-alt-cloudy",
              "night-alt-rain", "night-alt-rain", "day-rain-mix",
              "day-haze", "day-haze", "day-cloudy",
              "day-cloudy", "day-cloudy", "day-cloudy",
              "day-sunny-overcast", "day-sunny",
              "day-sunny", "day-sunny", "day-sunny", "day-sunny-overcast",
              "night-clear", "night-clear", "night-clear", "night-clear"),
  stringsAsFactors = FALSE
)


usethis::use_data(paris)
