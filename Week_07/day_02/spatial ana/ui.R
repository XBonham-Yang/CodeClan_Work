ui <- fluidPage(
  selectInput(
    "region",
    "which region",
    choice = regions
  ),
  leafletOutput("whisky_map")
)