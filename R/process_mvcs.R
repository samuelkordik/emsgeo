#' Process MVCs to add streets information
#'
#' Takes in MVCs incident information from ePCR,
#' streets shapefile, and then outputs merged fileset.
#'
#' @param mvcs_filename Source CSV file for MVCs
#' @param streets_filename Source shapefile for Streets
#' @param streets_layer layer to use from the streets shapefile
#' @param mvc_coords Column names in the MVCs file for lat/lon
#'
#' @return sf object fully merged
#' @export
process_mvcs <- function(mvcs_filename = here::here("../data/MVCs_Export.csv"),
                         streets_filename = here::here("../data/STREETS 2/STREETS.shp"),
                         streets_layer = "STREETS",
                         mvc_coords = c("scene_lon", "scene_lat")
                         )
{

  mvcs <- read_mvc_data(mvcs_filename)

  streets <- get_streets(streets_filename, streets_layer)

  incidents_sf <- incidents_as_sf(mvcs, coords = mvc_coords)


  merge_mvcs_streets(incidents_sf, streets)

}
