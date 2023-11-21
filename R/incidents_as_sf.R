#' Converts EMS incidents into sf object
#'
#' Takes incidents with latitude and longitude data and returns an sf object.
#' Notably only includes incidents with coordinates present.
#'
#' @param incidents
#' @param crs input string for crs, if one hasn't been determined when importing
#' streets using `get_streets()`.
#' @param coords pair-list of latitude and longitude columns
#'
#' @return sf object
#' @export
incidents_as_sf <- function(incidents, coords = c("scene_lon", "scene_lat"), crs = "EPSG:4326") {
  library(magrittr)

  #sf_incidents <-
  #incidents %>% dplyr::filter(!is.na(.data[[coords[1]]]),
  #                            !is.na(.data[[coords[2]]])) %>%
  #  sf::st_as_sf(coords = coords, crs = 4326)
  lon = rlang::sym(coords[1])
  lat = rlang::sym(coords[2])

  incidents %>% tidyr::drop_na(!!lon, !!lat) %>%
    sf::st_as_sf(coords = coords, crs = 4326)

  #sf::st_transform(sf_incidents, crs = 2276)
}
