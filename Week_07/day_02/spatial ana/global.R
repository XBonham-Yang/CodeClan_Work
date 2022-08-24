whisky_data <- CodeClanData::whisky

regions <- sort(unique(whisky_data$Region))
library(dplyr)
library(magrittr)
library(leaflet)
