
<!-- README.md is generated from README.Rmd. Please edit that file -->

# emsgeo

<!-- badges: start -->
<!-- badges: end -->

emsgeo contains helper functions for working with the geographic/spatial
aspect of EMS data. This was prepared for a very specific use case
scenario but may be extended further in the future. Collaboration to
extend this is welcome!

## Installation

You can install the development version of emsgeo like so:

``` r
devtools::install_github("samuelkordik/emsgeo")
```

## Usage

This package uses data from two sources: GIS shapefiles describing
roadways, and EMS CSV files containing ePCR elements. The package was
designed around using City of Dallas GIS shapefiles for streets, which
can be found
[here](https://egis.dallascityhall.com/resources/shapefileDownload.aspx).
The EMS CSV files for this package were exported from ImageTrend Elite,
but could be sourced from any ePCR with the necessary NEMSIS fields.

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(emsgeo)

## Set filenames for source data and details
mvcs_filename <- here::here("../data/MVCs_Export.csv")
streets_filename <- here::here("../data/STREETS 2/STREETS.shp")
streets_layer <- "STREETS"
mvc_coords = c("scene_lon", "scene_lat")

## Import data
mvcs <- read_mvc_data(mvcs_filename)
#> Warning: There were 3 warnings in `dplyr::mutate()`.
#> The first warning was:
#> ℹ In argument: `dplyr::across(...)`.
#> Caused by warning:
#> !  96 failed to parse.
#> ℹ Run `dplyr::last_dplyr_warnings()` to see the 2 remaining warnings.
streets <- get_streets(streets_filename, streets_layer)
#> Reading layer `STREETS' from data source 
#>   `/Users/S225608/Library/CloudStorage/OneDrive-UniversityofTexasSouthwestern/Documents/2 Quality Control & Data/2023-10 StreetLevelMVCs/data/STREETS 2/STREETS.shp' 
#>   using driver `ESRI Shapefile'
#> Simple feature collection with 100717 features and 34 fields
#> Geometry type: LINESTRING
#> Dimension:     XY
#> Bounding box:  xmin: 2430574 ymin: 6912294 xmax: 2591958 ymax: 7056822
#> Projected CRS: NAD83 / Texas North Central (ftUS)
incidents_sf <- incidents_as_sf(mvcs, coords = mvc_coords)

## Complete merge
merged <- merge_mvcs_streets(incidents_sf,
                             streets)


## Save out
readr::write_csv(as.data.frame(merged),
          here::here("../data/merged.csv"),
          append = FALSE)
```
