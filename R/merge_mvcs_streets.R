#' Get Street Attribute data for MVC incidents
#'
#' Completes a spatial join to get street attribute data for
#' MVCs within a specified distance of any given road.
#'
#' @param sf_incidents MVCs, as sf
#' @param streets Streets sf object
#'
#' @return
#' @export
#'
merge_mvcs_streets <- function(sf_incidents, streets) {
  epsg_crs <- sf::st_crs(streets)$epsg
  sf::st_join(sf_incidents %>% sf::st_transform(crs = epsg_crs),
              streets,
              join = sf::st_nearest_feature)
}
