
<!-- README.md is generated from README.Rmd. Please edit that file -->

# emsgeo

<!-- badges: start -->
<!-- badges: end -->

emsgeo contains helper functions for working with the geographic/spatial
aspect of EMS data.

## Installation

You can install the development version of emsgeo like so:

``` r
# FILL THIS IN! HOW CAN PEOPLE INSTALL YOUR DEV PACKAGE?
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
#library(emsgeo)
## basic example code
```

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
summary(cars)
#>      speed           dist       
#>  Min.   : 4.0   Min.   :  2.00  
#>  1st Qu.:12.0   1st Qu.: 26.00  
#>  Median :15.0   Median : 36.00  
#>  Mean   :15.4   Mean   : 42.98  
#>  3rd Qu.:19.0   3rd Qu.: 56.00  
#>  Max.   :25.0   Max.   :120.00
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this.

You can also embed plots, for example:

<img src="man/figures/README-pressure-1.png" width="100%" />

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.
