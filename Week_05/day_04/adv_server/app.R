
library(shiny)
library(tidyverse)

# read in and prep --------------------------------------------------------
students <- CodeClanData::students_big
handed <- unique(students$handed)
#radio button for handedness
#table to display data filtered by handedness
#only first 10 rows
# ui ----------------------------------------------------------------------
ui <- fluidPage(
  radioButtons("handed_input",
               "Handedness",
               choices = handed,
               inline = TRUE),
  tableOutput("table_output")
)


# server ------------------------------------------------------------------

server <- function(input, output){
  
  output$table_output <- renderTable({
    students %>% 
      filter(handed == input$handed_input) %>% 
      head(10)
  })
}


# run app -----------------------------------------------------------------

shinyApp(ui = ui,
         server = server)
