#' Join EMS incidents with nearby streets
#'
#' Joins EMS incidents with the Streets list based on nearby streets, based on
#' a given distance.
#'
#' @param sf_incidents sf object of EMS incidents
#' @param streets sf object of streets
#' @param distance numeric distance for points to be within
#' @param distance_units character string of units to pass to `units::set_units`
#'
#' @return sf object of join
#' @export
#'
#'
join_incidents_streets <- function(sf_incidents, streets, distance, distance_units) {

  sf::st_join(sf_incidents,
                        streets,
                        dist = units::set_units(distance, distance_units)
                        )

}
