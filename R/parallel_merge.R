#' Get Street Attribute data for MVC incidents Parallel
#'
#' Completes a spatial join to get street attribute data for
#' MVCs within a specified distance of any given road.
#'
#' Uses paralellization
#'
#' @param sf_incidents MVCs, as sf
#' @param streets Streets sf object
#' @param distance Distance units
#'
#' @return
#' @export
#'
pmerge_mvcs_streets <- function(mvcs, streets, distance = units::set_units(10, "m")) {
  # https://gis.stackexchange.com/questions/241255/efficient-spatial-joining-for-large-dataset-in-r
  no_cores <- parallel::detectCores() - 1

  # Cut df into "n" parts
  n <- 1000
  parts <- split(x = 1:length(mvcs), f = cut(1:length(mvcs), n))

  epsg_crs <- sf::st_crs(streets)$epsg
  sf::st_join(sf_incidents %>% sf::st_transform(crs = epsg_crs),
              streets,
              join = sf::st_is_within_distance,
              dist = distance)
}
