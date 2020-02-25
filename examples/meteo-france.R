


# Packages ----------------------------------------------------------------

library(sf)
library(rnaturalearth)
library(ggplot2)
library(weather)
library(data.table)
library(darksky)



# Data --------------------------------------------------------------------

# Geo
europe <- ne_countries(continent = "europe", returnclass = "sf", scale = "large")
france <- ne_states(geounit = "france", returnclass = "sf")

# Take regions centroids
france_dt <- as.data.table(france)
france_dt <- france_dt[, list(
  x = st_coordinates(st_centroid(st_combine(geometry)))[, 1],
  y = st_coordinates(st_centroid(st_combine(geometry)))[, 2]
), by = gns_region]
france_dt <- france_dt[!is.na(gns_region)]

# Get weather forecast by region
france_dt[, c("icon", "temperature", "time", "precipIntensity") := {
  daily <- get_current_forecast(
    latitude = y,
    longitude = x,
    exclude = "currently,minutely,hourly,alerts,flags",
    units = "auto"
  )$daily
  daily <- daily[as.character(daily$time) == Sys.Date() + 1, ]
  list(
    icon = daily$icon,
    temperature = daily$temperatureHigh,
    time = daily$time,
    precipIntensity = daily$precipIntensity
  )
}, by = gns_region]




# Plot --------------------------------------------------------------------

ggplot() +
  geom_sf(data = europe, fill = "#d1e0e8", colour = "#d1e0e8") +
  geom_sf(data = france, fill = "#93d02d", colour = "#a0d647") +
  geom_weather(
    data = france_dt,
    mapping = aes(x, y, weather = icon),
    api = "darksky", size = 15#, colour = "#FFFFFF"
  ) +
  geom_text(
    data = france_dt,
    mapping = aes(x, y, label = round(temperature)),
    nudge_y = 0.35
  ) +
  coord_sf(
    xlim = st_bbox(france)[c("xmin", "xmax")],
    ylim = st_bbox(france)[c("ymin", "ymax")]
  ) +
  theme(panel.background = element_rect(fill = "#dde9f0"))+
  labs(
    x = NULL, y = NULL,
    title = paste(
      "Prévisions du",
      format(france_dt$time[1], format = "%A %d %B")
    ),
    subtitle = paste("à", format(Sys.time(), format = "%H:%M le %d/%m"))
  )


