
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cactusapi

<!-- badges: start -->

[![R-CMD-check](https://github.com/RaoulWolf/cactusapi/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/RaoulWolf/cactusapi/actions/workflows/R-CMD-check.yaml)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![Codecov test
coverage](https://codecov.io/gh/RaoulWolf/cactusapi/branch/master/graph/badge.svg)](https://app.codecov.io/gh/RaoulWolf/cactusapi?branch=master)
<!-- badges: end -->

> A [ZeroPM](https://zeropm.eu/) R package

The goal of the cactusapi package is to provide a minimal and
lightweight interface to the [CACTUS Chemical Identifier
Resolver](https://cactus.nci.nih.gov/chemical/structure) API services.

The dependency of cactusapi is kept at a bare minimum:
[curl](https://cran.r-project.org/web/packages/curl/index.html) for
handling the API requests.

## Installation

You can install the development version of cccapi from
[GitHub](https://github.com/) with:

``` r
# install.packages(devtools)
remotes::install_github("RaoulWolf/cactusapi")
```

## Example

This is a basic example which shows you how to get the InChI
representation of caffeine:

``` r
library(cactusapi)

get_representation("caffeine", "StdInChI")
#> [1] "InChI=1S/C8H10N4O2/c1-10-4-9-6-5(10)7(13)12(3)8(14)11(6)2/h4H,1-3H3"
```

## Acknowledgement

This R package was developed by the EnviData initiative at the
[Norwegian Geotechnical Institute (NGI)](https://www.ngi.no/eng) as part
of the project [ZeroPM: Zero pollution of Persistent, Mobile
substances](https://zeropm.eu/). This project has received funding from
the European Union’s Horizon 2020 research and innovation programme
under grant agreement No 101036756.

------------------------------------------------------------------------

If you find this package useful and can afford it, please consider
making a donation to a humanitarian non-profit organization, such as
[Sea-Watch](https://sea-watch.org/en/). Thank you.
