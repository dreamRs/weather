
#  ------------------------------------------------------------------------
#
# Title : Read and transform SVG
#  Date : 2019-10-30
#
#  ------------------------------------------------------------------------



# Packages ----------------------------------------------------------------

library(rsvg)
library(grImport2)




# Convert to good SVG format ----------------------------------------------

path_source <- "inst/assets/svg/"
path_dest <- "inst/assets/svg/"

# for (i in list.files(path = path_source)) {
#   rsvg_svg(svg = file.path(path_source, i), file = file.path(path_dest, i))
# }




# Read SVG ----------------------------------------------------------------

svg_files <- list.files(path = path_dest)
weather_icons <- lapply(
  X = file.path(path_dest, svg_files),
  FUN = readPicture
)
names(weather_icons) <- gsub(pattern = "wi-(.*)\\.svg", replacement = "\\1", x = svg_files)





# Save --------------------------------------------------------------------

weather_icons_grob <- weather_icons
usethis::use_data(weather_icons_grob, internal = TRUE, overwrite = TRUE)


