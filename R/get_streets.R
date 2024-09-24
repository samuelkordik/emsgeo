#' Get streets shape file
#'
#' Expects a streets shapefile with line features
#'
#' @param filename Streets shape file
#' @param layer what layer to pull from
#'
#' @return sf object
#' @export
get_streets <- function(filename = here::here("../data/STREETS 2/STREETS.shp"), layer = "STREETS") {

  streets <- sf::st_read(filename, layer = layer)

  # Put CRS into internal environment
  the <- new.env(parent = emptyenv())
  the$CRS <- sf::st_crs(streets)$input

  streets |>
    dplyr::select(street_prefix = PREFIX,
           street_name = NAME,
           street_type = TYPE,
           street_suffix = SUFFIX,
           left_from_addr = L_F_ADD,
           left_to_addr = L_T_ADD,
           right_from_addr = R_F_ADD,
           right_to_addr = R_T_ADD,
           city_left_side = CITY_L,
           city_right_side = CITY_R,
           street_class = CLASS,
           street_speed_limit = SPEED,
           street_dir = ONE_WAY,
           school_zone = SCHL_ZONE,
           street_zip_left = POSTAL_L,
           street_zip_right = POSTAL_R,
           street_hwy_num = HWY_NUM,
           street_hwy_type = SHIELD,
           street_fullname = FULLSTREET,
           SHAPE_len,
           geometry
           )
}
