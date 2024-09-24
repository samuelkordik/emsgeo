#' Plots incidents alone
#'
#' Plots incidents alone, using included latitude and longitude.
#'
#' @param sf_incidents sf object of incidents
#'
#' @return Outputs a ggplot2 plot of the incidents.
#' @export
plot_incidents <- function(sf_incidents) {
  ggplot2::ggplot(data = sf_incidents) + ggplot2::geom_sf()
}
