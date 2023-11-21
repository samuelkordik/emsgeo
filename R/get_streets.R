#' Get streets shape file
#'
#' Expects a streets shapefile with line features
#'
#' @param filename Streets shape file
#'
#' @return sf object
#' @export
get_streets <- function(filename = here::here("../data/STREETS 2/STREETS.shp"), layer = "STREETS") {
  streets <- sf::st_read(filename, layer = layer)

  # Put CRS into internal environment
  the <- new.env(parent = emptyenv())
  the$CRS <- sf::st_crs(streets)$input

  streets
}
