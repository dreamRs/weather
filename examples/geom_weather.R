library(ggplot2)
library(weather)

ggplot(data = paris) +
  geom_weather(aes(hour, temperature, weather = weather)) +
  theme_minimal()

# With colors
hours <- as.POSIXlt(paris$hour)$hour
paris$color <- ifelse(
  hours > 7 & hours < 21,
  "day",
  "night"
)
ggplot(data = paris) +
  geom_weather(aes(
    hour, temperature,
    weather = weather,
    color = color
  )) +
  scale_color_manual(values = c(
    "day" = "darkgoldenrod3",
    "night" = "gray20"
  )) +
  theme_minimal()

