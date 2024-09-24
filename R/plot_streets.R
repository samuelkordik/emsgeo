#' Plots Streets
#'
#' Plots streets data using `sf` and `ggplot`, optionally filtering by
#' class. Expects streets to have a column named "CLASS" to filter against.
#'
#' @param streets sf data frame of streets
#' @param classes character list of class types to include.
#'
#' @return ggplot element
#' @export
#'
plot_streets <- function(streets, classes) {
  dplyr::filter(streets, CLASS %in% classes) |>  ggplot2::ggplot() +
    ggplot2::geom_sf(
      ggplot2::aes(color = CLASS)
    ) +
    ggplot2::theme_bw() +
    ggplot2::coord_sf()
}
