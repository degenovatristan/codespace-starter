#
#
#
#
#
#
#
#
#
#| message: false
library(tidyverse)
library(purrr)
library(leaflet)
library(rvest)
library(httr2)
library(jsonlite)
#
#
#
raw <- fromJSON("data/wildfires.geojson")
length(raw$features)
#
#
#
first_fire <- raw$features[1, ]
names(first_fire)
#
#
#
first_fire$geometry$coordinates[[1]][1, 1, ]
#
#
#
features_tbl <- tibble(features = raw$features)
features_tbl
#
#
#
features_wide <- features_tbl |>
  unnest_wider(features)
features_wide
#
#
#
properties_wide <- features_wide |>
  unnest_wider(properties)
properties_wide
#
#
#
#| cache: true
fires <- properties_wide |>
  unnest_wider(geometry, names_sep = "_") |>
  select(incident, gis_acres, fire_year, agency, state, geometry_coordinates) |>
  mutate(
    gis_acres = as.numeric(gis_acres),
    fire_year = as.integer(fire_year)
  )
#
#
#
#
