
#' Read MVC Incident Data
#'
#' Reads the MVC data from an ImageTrend Bulk Export,
#' corrects column types, creates factors where needed,
#' and outputs a tibble with the necessary contents.
#'
#' @param filename Filename of data to pull in.
#'
#' @return tibble with imported and corrected file.
#' @export
read_mvc_data <- function(filename = here::here("../data/MVCs_Export.csv")) {

  # NOTE: THE COLUMN SPECS are very specific to this imagetrend export.

  df <- readr::read_csv(filename, col_types = readr::cols(incident_number = readr::col_character(),
                                                          scene_lat = readr::col_double(),
                                                          scene_lon = readr::col_double(),
                                                          scene_lat_CAD = readr::col_double(),
                                                          scene_lat_CAD2 = readr::col_double(),
                                                          scene_lon_CAD = readr::col_double(),
                                                          scene_lon_CAD2 = readr::col_double(),
                                                          scene_lat2 = readr::col_double(),
                                                          scene_lon2 = readr::col_double(),
                                                          .default = readr::col_character()
                                                          ))

  # Fix NA values in datetimes
  df <- df |> dplyr::mutate(dplyr::across(dplyr::ends_with("_datetime"),
                                 ~ replace(.x,
                                          .x %in% c("Not Applicable",
                                                   "Not Recorded",
                                                   "PatientArrivalDateTimeModifier_NotValue_NotApplicable"),
                                          NA)))

  # Convert datetimes
  df <- df |> dplyr::mutate(dplyr::across(dplyr::ends_with("_datetime"),
                                             ~lubridate::parse_date_time(.x,
                                                                         c("mdY IMSp",
                                                                           "mdY IMp"
                                                                           ),
                                                                         tz = "America/Chicago")))
  # Using lubridate::parse_date_time due to multiple formats in ImageTrend bulk exports


  # Add intervals
  df <- df |>
    dplyr::mutate(call_to_onscene_interval = int_len(psap_datetime, onscene_datetime),
                  scenetime_interval = int_len(onscene_datetime, transport_datetime),
                  transport_interval = int_len(transport_datetime, atdest_datetime),
                  response_interval = int_len(dispatched_datetime, onscene_datetime),
                  chute_interval = int_len(dispatched_datetime, enroute_datetime)
                  )

  # Remove outlier/wrong intervals; adjust intervals that are within 60 seconds up to 0.
  df <- df |>
    dplyr::mutate(dplyr::across(dplyr::ends_with("_interval"),
                                ~ replace(.x,
                                          .x < -60,
                                          NA))) |>
    dplyr::mutate(dplyr::across(dplyr::ends_with("_interval"),
                                ~ replace(.x,
                                          .x < 0,
                                          0)))


  df
}


#' Get the duration in seconds between two points in time
#'
#' See the specifications for `lubridate::interval`
#'
#' @param start Date times
#' @param end Date times
#'
#' @return duration in seconds
int_len <- function(start, end) {
  lubridate::int_length(lubridate::interval(start, end))
}
